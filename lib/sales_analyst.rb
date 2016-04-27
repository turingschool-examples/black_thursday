class SalesAnalyst
  attr_reader :merchants, :items, :se, :invoices, :invoice_items

  def initialize(se)
    @se = se
    @merchants = se.merchants
    @items = se.items
    @invoices = se.invoices
    @invoice_items = se.invoice_items
  end

  def items_per_merchant
    merchants.all.map do |merchant|
      merchant.items.count
    end
  end

  def average_items_per_merchant
    (items_per_merchant.reduce(:+) / items_per_merchant.length.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    item_counts = items_per_merchant
    average = average_items_per_merchant
    difference_squared = item_counts.reduce(0) do |sum, item_count|
      sum + (item_count - average) ** 2
    end
    take_square_root_of(difference_squared, item_counts.length - 1)
  end

  def take_square_root_of(difference_squared, count)
    Math.sqrt(difference_squared / (count)).round(2)
  end

  def merchants_with_high_item_count
    merchants_with_item_counts.map do |merchant_hash|
      merchant_hash[:merchant] if merchant_hash[:item_count] > avg_std_dev
    end.compact
  end

  def avg_std_dev
   average_items_per_merchant_standard_deviation + average_items_per_merchant
  end

  def merchants_with_item_counts
    merchants.all.map do |merchant|
      { :merchant => merchant, :item_count => merchant.items.count }
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_items = merchants.find_by_id(merchant_id).items
    summed_item_price = merchant_items.reduce(0) do |sum, item|
      sum + item.unit_price
    end
    (summed_item_price / merchant_items.length).round(2)
  end

  def average_average_price_per_merchant
    sum_of_averages = merchants.all.reduce(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id)
    end
    (sum_of_averages / merchants.all.length).round(2)
  end

  def all_items_unit_prices
    items.all.map { |item| item.unit_price }
  end

  def average_items_price
    all_items_unit_prices.reduce(:+) / all_items_unit_prices.length
  end

  def items_price_standard_deviation
    all_unit_prices = all_items_unit_prices
    average_price_of_items = average_items_price
    difference_squared = all_unit_prices.reduce(0) do |sum, item_price|
      sum + (item_price - average_price_of_items) ** 2
    end
    take_square_root_of(difference_squared, all_unit_prices.length - 1)
  end

  def golden_items
    items_standard_deviation = items_price_standard_deviation
    items.all.find_all do |item|
      item.unit_price > items_standard_deviation * 2
    end
  end

  def invoices_per_merchant
    merchants.all.map { |merchant| merchant.invoices.count }
  end

  def average_invoices_per_merchant
    invoice_count = invoices_per_merchant.length
    (invoices_per_merchant.reduce(:+) / invoice_count.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    merchant_invoice_count = invoices_per_merchant
    average_merchant_invoices = average_invoices_per_merchant
    difference_squared = merchant_invoice_count.reduce(0) do |sum, count|
      sum + (count - average_merchant_invoices) ** 2
    end
    take_square_root_of(difference_squared, merchant_invoice_count.length - 1)
  end

  def top_merchants_by_invoice_count
    average = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation
    merchants.all.find_all do |merchant|
      merchant.invoices.count > (average + (standard_deviation * 2))
    end
  end

  def bottom_merchants_by_invoice_count
    average = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation
    merchants.all.find_all do |merchant|
      merchant.invoices.count < (average - (standard_deviation * 2))
    end
  end

  def days_with_invoices
    invoices.all.group_by { |invoice| invoice.created_at.strftime("%A") }
  end

  def days_with_count
    days_with_invoices.map { |key, value| ({ key => value.length }) }
  end

  def invoices_by_day
    days_with_count.map do |hash|
      hash.values
    end.flatten
  end

  def invoices_by_day_average
    invoices_by_day.reduce(:+) / invoices_by_day.length
  end

  def standard_deviation(elements, average)
    square_difference = elements.map { |number| (number - average) ** 2 }
    take_square_root_of(square_difference.reduce(:+), elements.length - 1)
  end

  def top_days_by_invoice_count
    top_days = []
    day_deviation = standard_deviation(invoices_by_day, invoices_by_day_average)
    days_with_count.each do |hash|
      hash.each do |key, value|
      top_days << key if value > (invoices_by_day_average + day_deviation)
      end
    end
    top_days
  end

  def invoice_status(status)
    total = invoices.all.count { |invoice| invoice }
    invoice_statuses = invoices.all.count { |invoice| invoice.status == status }
    ((invoice_statuses / total.to_f) * 100).round(2)
  end

  def total_revenue_by_date(date)
    invoices.all.map do |invoice|
      if invoice.created_at.strftime("%Y-%m-%d") == date.strftime("%Y-%m-%d")
        invoice.paid_total
      end
    end.compact.reduce(:+)
  end

  def merchants_with_pending_invoices
    merchants.all.find_all do |merchant|
      merchant.invoices.any? do |invoice|
         invoice.transactions.none? do |transaction|
           transaction.result == "success"
         end
      end
    end
  end

  def merchants_with_only_one_item
    merchants.all.find_all { |merchant| merchant.items.count == 1 }
  end

  def revenue_by_merchant(merchant_id)
    merchant = merchants.find_by_id(merchant_id)
    merchant.invoices.reduce(0) do |sum, invoice|
      sum + invoice.paid_total
    end
  end

  def merchants_ranked_by_revenue
    merchant_revenues = merchants.all.map do |merchant|
      { :merchant => merchant, :revenue => revenue_by_merchant(merchant.id) }
    end
    ranked_merchants = merchant_revenues.sort_by do |merchant_revenue_hash|
      merchant_revenue_hash[:revenue]
    end
    ranked_merchants.reverse.map do |ranked_merchant|
      ranked_merchant[:merchant]
    end
  end

  def top_revenue_earners(x = 20)
    merchants_ranked_by_revenue.take(x)
  end

  def merchants_created_in_month(month)
    merchants.all.find_all do |merchant|
        merchant.created_at.strftime("%B") == month
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_created_in_month(month).find_all do |merchant|
      merchant.items.count == 1
    end
  end

  def paid_items_for_merchant(merchant_id)
    merchant = merchants.find_by_id(merchant_id)
    paid_invoices = merchant.invoices.find_all do |invoice|
      invoice.is_paid_in_full?
    end
    paid_invoices.map { |invoice| invoice.invoice_items }
  end

  def most_sold_item_for_merchant(merchant_id)
    paid_items = paid_items_for_merchant(merchant_id)
    freq = paid_items.flatten.map { |invoice_item| [invoice_item, invoice_item.quantity.to_i] }
    top = freq.map { |item, f| f }
    max = top.max
    most_sold = freq.find_all { |i, f| f == max }
    most_sold_items = most_sold.map { |i, f| i.item }
  end

  def best_item_for_merchant(merchant_id)
    paid = paid_items_for_merchant(merchant_id)
    prices = paid.flatten.map { |invoice_item| [invoice_item, invoice_item.unit_price * invoice_item.quantity.to_i] }
    top = prices.max_by { |item, price| price }
    top[0].item
  end
end

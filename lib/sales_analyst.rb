require "pry"

class SalesAnalyst

  attr_reader :merchant_repo,
  :item_repo,
  :invoice_repo,
  :invoice_item_repo

  def initialize(sales_engine)
    @se = sales_engine
    @merchant_repo = sales_engine.merchants
    @item_repo = sales_engine.items
    @invoice_repo = sales_engine.invoices
    @invoice_item_repo = sales_engine.invoice_items
  end
  #items per merchant
  def average_items_per_merchant
    total_merchants = merchant_repo.all.count
    total_items = item_repo.all.count
    (total_items.to_f / total_merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    deviation = sum_deviation(average)
    denominator = merchant_repo.all.count - 1
    Math.sqrt(deviation / denominator).round(2)
  end

  def sum_deviation(average)
    merchant_repo.all.reduce(0) do |deviation, merchant|
      deviation += (merchant.items.count - average) ** 2
    end
  end

  def merchants_with_high_item_count
    average = average_items_per_merchant
    standard_deviation = average_items_per_merchant_standard_deviation
    merchant_repo.all.select do |merchant|
      merchant.items.count > (standard_deviation + average)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items = item_repo.find_all_by_merchant_id(merchant_id)
    item_unit_price = items.reduce(0) do |total, item|
      total += item.unit_price
    end
    (item_unit_price / items.count).round(2)
  end

  def average_average_price_per_merchant
    sum = merchant_repo.all.reduce(0) do |total, merchant|
      total += average_item_price_for_merchant(merchant.id)
    end
    (sum / merchant_repo.all.count).floor(2)
  end

  #items
  def golden_items
    average = average_item_price
    deviation = standard_deviation_in_items_price(average)
    item_repo.all.select do |item|
      item.unit_price > average + deviation * 2
    end
  end

  def average_item_price
    sum = item_repo.all.reduce(0) do |total, item|
      total += item.unit_price
    end
    sum / item_repo.all.count
  end

  def standard_deviation_in_items_price(average)
    deviation = item_repo.all.reduce(0) do |total, item|
      total += (item.unit_price - average) ** 2
    end
    item_count = item_repo.all.count
    Math.sqrt(deviation / (item_count - 1))
  end

  #invoices per merchant
  def average_invoices_per_merchant
    invoice_count = invoice_repo.all.count
    merchant_count= merchant_repo.all.count
    (invoice_count.to_f / merchant_count).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    average = average_invoices_per_merchant
    deviation  = standard_deviation_in_invoices(average)
    merchants = merchant_repo.all.count
    Math.sqrt(deviation/(merchants - 1)).round(2)
  end

  def standard_deviation_in_invoices(average)
    merchant_repo.all.reduce(0) do |total, merchant|
      total += (merchant.invoices.count - average) ** 2
    end
  end

  def top_merchants_by_invoice_count
    average = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation
    result = merchant_repo.all.select do |merchant|
      merchant.invoices.count > (average + (standard_deviation * 2))
    end
    return result || []
  end

  def bottom_merchants_by_invoice_count
    average = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation
    result = merchant_repo.all.select do |merchant|
      merchant.invoices.count <= (average - (standard_deviation * 2))
    end
    result || []
  end

  #invoices by day
  def average_invoices_per_day
    invoice_repo.all.count / 7
  end

  def group_invoices_by_day
    invoice_repo.all.group_by do |invoice|
      invoice.created_at.strftime("%A")
    end
  end

  def average_invoices_per_day_standard_deviation
    average = average_invoices_per_day
    deviation = deviation_in_invoices_per_day(average)
    Math.sqrt(deviation / 6).round(2)
  end

  def deviation_in_invoices_per_day(average)
    invoices_on_days = group_invoices_by_day
    sum = invoices_on_days.values.reduce(0) do |total, invoices_on_day|
      total += (invoices_on_day.count - average) ** 2
    end
    sum
  end
  def top_days_by_invoice_count
    average = average_invoices_per_day
    standard_deviation = average_invoices_per_day_standard_deviation
    invoices_by_days = group_invoices_by_day
    invoices_by_days.keys.select do |day|
      invoices_by_days[day].count > average + standard_deviation
    end
  end
  def invoice_status(status)
    invoice_count = invoice_repo.all.count
    invoices_with_status = invoice_repo.find_all_by_status(status).count
    (invoices_with_status.to_f / invoice_count * 100.0).round(2)
  end

  #revenue info
  def revenue_by_merchant(merchant_id)
    merchants_invoices = @se.find_all_invoices_by_merchant_id(merchant_id)
    merchants_invoices.reduce(0) do |revenue, invoice|
      revenue += invoice.total if invoice.is_paid_in_full?
      revenue
    end
  end

  def total_revenue_by_date(date)
    total_invoices = invoice_repo.all.select do |invoice|
      invoice.created_at == date
    end
    total_invoices.reduce(0) do |revenue, invoice|
      revenue += invoice.total if invoice.is_paid_in_full?
      revenue
    end
  end

  def top_revenue_earners(threshhold = 20)
    merchants_ranked_by_revenue[0..threshhold - 1]
  end

  def merchants_ranked_by_revenue
    sorted_merchants = merchant_repo.all.sort_by do |merchant|
      revenue_by_merchant(merchant.id)
    end
    sorted_merchants.reverse
  end

  def merchants_with_pending_invoices
    merchant_repo.all.select do |merchant|
      merchant_invoices = invoice_repo.find_all_by_merchant_id(merchant.id)
      merchant_invoices.any? do |invoice|
        not invoice.is_paid_in_full?
      end
    end
  end

  def merchants_with_only_one_item
    merchant_repo.all.select do |merchant|
      merchant_items = item_repo.find_all_by_merchant_id(merchant.id)
      merchant_items.count == 1
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchant_repo.all.select do |merchant|
      merchant_items = item_repo.find_all_by_merchant_id(merchant.id)
      merchant_items.count == 1 && merchant.created_at.strftime("%B") == month
    end
  end

  def most_sold_item_for_merchant(merchant_id)
    paid_invoice_items = paid_invoice_items_for_merchant(merchant_id)
    items_from_invoices = paid_invoice_items.map do |invoice_item|
      invoice_item.item
    end.uniq
    grouped_items = items_from_invoices.group_by do |item|
      quantity_of_item_over_all_invoices(item, paid_invoice_items)
    end
    grouped_items[grouped_items.keys.max]
  end

  def best_item_for_merchant(merchant_id)
    paid_invoice_items = paid_invoice_items_for_merchant(merchant_id)
    items_from_invoices = paid_invoice_items.map do |invoice_item|
      invoice_item.item
    end.uniq
    grouped_items = items_from_invoices.sort_by do |item|
      paid_invoice_items.reduce(0) do |revenue, invoice_item|
        if invoice_item.item_id == item.id
          revenue += invoice_item.quantity * invoice_item.unit_price
        end
        revenue
      end
    end
    grouped_items.last
  end

  def quantity_of_item_over_all_invoices(item, paid_invoice_items)
    paid_invoice_items.reduce(0) do |total, invoice_item|
      total += invoice_item.quantity if invoice_item.item_id == item.id
      total
    end
  end

  def paid_invoice_items_for_merchant(merchant_id)
    invoices_by_merchant = invoice_repo.find_all_by_merchant_id(merchant_id)
    invoices_by_merchant.reduce([]) do |result, invoice|
      if invoice.is_paid_in_full?
        result += invoice_item_repo.find_all_by_invoice_id(invoice.id)
      end
      result
    end
  end

end

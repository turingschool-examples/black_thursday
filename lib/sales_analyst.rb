require_relative 'sales_engine'
require_relative 'standard_deviation'
require 'bigdecimal'

class SalesAnalyst
  include StandardDeviation
  attr_reader :se

  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    average = se.total_items / se.total_merchants.to_f
    average.round(2)
  end

  def merchants_with_high_item_count
    std_dev = average_items_per_merchant_standard_deviation

    se.merchants.merchants.select do |merchant|
      merchant.items.count >= std_dev * 2
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = se.merchants.find_by_id(merchant_id)

    total_item_price = merchant.items.reduce(0) do |total_price, item|
      total_price + item.unit_price
    end
    if not total_item_price == 0
      return (total_item_price / merchant.items.count).round(2)
    else
      return 0
    end
  end

  def average_average_price_per_merchant
    price_averages = se.merchants.merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    average_average = price_averages.sum / price_averages.count
    average_average.round(2)
  end

  def golden_items
    std_dev = item_standard_deviation
    se.items.items.select do |item|
      item.unit_price >  std_dev * 2
    end
  end

  def average_invoices_per_merchant
    average = se.total_invoices / se.total_merchants.to_f
    average.round(2)
  end

  def top_merchants_by_invoice_count
    average = average_invoices_per_merchant
    std_dev = average_invoices_per_merchant_standard_deviation
    se.merchants.merchants.select do |merchant|
      merchant.invoices.count > (average + std_dev * 2)
    end
  end

  def bottom_merchants_by_invoice_count
    average = average_invoices_per_merchant
    std_dev = average_invoices_per_merchant_standard_deviation
    se.merchants.merchants.select do |merchant|
      merchant.invoices.count < (average - std_dev * 2)
    end
  end

  def top_days_by_invoice_count
    average = average_invoices_per_day
    invoice_count_by_day = se.number_of_invoices_by_day
    std_dev = daily_invoice_standard_deviation.ceil

    top_days = invoice_count_by_day.select do |day, number|
      invoice_count_by_day[day] > (average + std_dev)
    end
    top_days.keys
  end

  def average_invoices_per_day
    se.total_invoices.to_f / 7
  end

  def invoice_status(status)
    count = 0
    se.invoices.invoices.each {|invoice| count += 1 if invoice.status == status}
    percentage = count / se.total_invoices.to_f * 100
    percentage.round(2)
  end

  def total_revenue_by_date(date)
    count = 0.00
    se.invoices.invoices.each do |invoice|

      invoice_date = invoice.created_at.strftime('%Y-%m-%d')
      if invoice_date == date.strftime('%Y-%m-%d')

        invoice.invoice_items.each do |invoice_item|
          count += invoice_item.unit_price * invoice_item.quantity
        end
      end
    end
    count
  end

  def top_revenue_earners(n = 20)
    merchants_ranked_by_revenue[0,n]
  end

  def merchants_ranked_by_revenue
    se.merchants.merchants.sort_by do |merchant|
      merchant_revenue(merchant)
    end.reverse
  end

  def merchant_revenue(merchant)
    revenue= 0.00
    merchant.invoices.each do |invoice|
      revenue += invoice.total if invoice.is_paid_in_full?
    end
    revenue
  end

  def merchants_with_pending_invoices
    se.merchants.all.select do |merchant|
      merchant.invoices.any? do |invoice|
        invoice.transactions.all? do |transaction|
          transaction.result == 'failed'
        end
      end
    end
  end

  def paid_invoices
    se.invoices.all.select {|invoice| invoice.is_paid_in_full?}
  end

  def merchants_with_only_one_item_registered_in_month(month_name)
    merchants = merchants_with_only_one_item
    one_item_merchants_by_month = merchants.group_by do |merchant|
      merchant.created_at.strftime('%B')
    end
    one_item_merchants_by_month[month_name]
  end

  def item_in_month?(merchant, month_name)
    items_in_month = merchant.items.select do |item|
      item.created_at.strftime('%B') == month_name
    end
    items_in_month.length == 1
  end

  def merchant_by_month_created
    se.merchants.all.group_by do |merchant|
      merchant.created_at.strftime('%B')
    end
  end

  def merchants_with_only_one_item
    se.merchants.all.select do |merchant|
      merchant.items.count == 1
    end
  end

  def revenue_by_merchant(merchant_id)
    merchant = se.merchants.find_by_id(merchant_id)
    revenue = merchant_revenue(merchant)
    BigDecimal.new(revenue, 4)
  end

  # def total_sold_for_item(item)
  #   item.invoice_items.reduce(0) do |total_sold, invoice_item|
  #     total_sold + invoice_item.quantity
  #   end
  # end

  def paid_invoices(merchant)
    merchant.invoices.select do |invoice|
      invoice.is_paid_in_full?
    end
  end

  def paid_invoice_items(paid_invoices)
    paid_invoices.map do |invoice|
      invoice.invoice_items
    end.flatten
  end


  def item_id_with_invoice_items(invoice_items)
    invoice_items.group_by do |invoice_item|
      invoice_item.item_id
    end
  end

  def total_sold_for_item(item_id_with_invoice_items)
    item_id_with_invoice_items.each do |k, v|
      total_sold = v.reduce(0) do |sum, invoice_item|
        sum + invoice_item.quantity
      end
      item_id_with_invoice_items[k] = total_sold
    end
    item_id_with_invoice_items
  end

  def total_revenue_for_item(item_id_with_invoice_items)
    item_id_with_invoice_items.each do |k, v|
      total_sold = v.reduce(0) do |sum, invoice_item|
        sum + invoice_item.quantity * invoice_item.unit_price
      end
      item_id_with_invoice_items[k] = total_sold
    end
    item_id_with_invoice_items
  end

  def find_max_value(items_sold_hash)
    items_sold_hash.values.max
  end

  def find_items_with_max_value(items_sold_hash)
    max_num_sold = find_max_value(items_sold_hash)
    item_ids = []
    items_sold_hash.each do |item_id, num|
      if num == max_num_sold
        item_ids << item_id
      end
    end
    item_ids
  end

  def find_items_by_id(item_id_array)
    most_sold_items = []
    if item_id_array.class == Integer
      most_sold_items << se.items.find_by_id(item_id_array)
    else
      item_id_array.each do |item_id|
        most_sold_items << se.items.find_by_id(item_id)
      end
    end
    most_sold_items
  end

  def most_sold_item_for_merchant(merchant_id)
    merchant = se.merchants.find_by_id(merchant_id)
    paid_invoices = paid_invoices(merchant)
    invoice_items = paid_invoice_items(paid_invoices)
    sorted_invoice_items = item_id_with_invoice_items(invoice_items)
    sold_items = total_sold_for_item(sorted_invoice_items)
    most_sold_items_by_id = find_items_with_max_value(sold_items)
    find_items_by_id(most_sold_items_by_id)
  end

  def best_item_for_merchant(merchant_id)
    merchant = se.merchants.find_by_id(merchant_id)
    paid_invoices = paid_invoices(merchant)
    invoice_items = paid_invoice_items(paid_invoices)
    sorted_invoice_items = item_id_with_invoice_items(invoice_items)
    item_revenues = total_revenue_for_item(sorted_invoice_items)
    most_sold_items_by_id = find_items_with_max_value(item_revenues)
    find_items_by_id(most_sold_items_by_id).first
  end

end

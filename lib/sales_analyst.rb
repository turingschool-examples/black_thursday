require 'bigdecimal'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    num_items = sales_engine.items.all.length.to_f
    num_merchants = sales_engine.merchants.all.length
    (num_items/num_merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(item_count_by_merchant)
  end

  def merchants_with_high_item_count
    threshold = average_items_per_merchant +
                average_items_per_merchant_standard_deviation
    sales_engine.merchants.all.find_all do |merchant|
      merchant.items.length >= threshold
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = sales_engine.merchants.find_by_id(merchant_id)
    aggregate_price = merchant.items.reduce(0) do |sum, item|
      sum + item.unit_price
    end
    (aggregate_price/merchant.items.length).round(2)
  end

  def average_average_price_per_merchant
    sum_averages = sales_engine.merchants.all.reduce(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id)
    end
    num_merchants = sales_engine.merchants.all.length
    (sum_averages/num_merchants).round(2)
  end

  def golden_items
    threshold = item_price_average +
                (2 * item_price_standard_deviation)
    sales_engine.items.all.find_all do |item|
      item.unit_price_to_dollars >= threshold
    end
  end

  def average_invoices_per_merchant
    num_invoices = sales_engine.invoices.all.length.to_f
    num_merchants = sales_engine.merchants.all.length
    (num_invoices/num_merchants).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(invoice_count_by_merchant)
  end

  def top_merchants_by_invoice_count
    threshold = average_invoices_per_merchant +
            2 * average_invoices_per_merchant_standard_deviation
    sales_engine.merchants.all.find_all do |merchant|
      merchant.invoices.length >= threshold
    end
  end

  def bottom_merchants_by_invoice_count
    threshold = average_invoices_per_merchant -
            2 * average_invoices_per_merchant_standard_deviation
    sales_engine.merchants.all.find_all do |merchant|
      merchant.invoices.length <= threshold
    end
  end

  def top_days_by_invoice_count
    threshold = average_invoices_per_day +
          standard_deviation(group_invoices_by_day_count.values)
    group_invoices_by_day_count.delete_if do | key, value |
      value <= threshold
    end.keys
  end

  def invoice_status(status)
    (group_invoices_status[status].length.to_f /
    sales_engine.invoices.all.length * 100).round(2)
  end

  def item_price_array
    sales_engine.items.all.map do |item|
      item.unit_price_to_dollars
    end.sort
  end

  def item_price_average
    average(item_price_array).round(2)
  end

  def item_price_standard_deviation
    standard_deviation(item_price_array)
  end

  def item_count_by_merchant
    sales_engine.merchants.all.map do |merchant|
      merchant.items.length
    end.sort
  end

  def item_count_standard_deviation
    standard_deviation(item_count_by_merchant)
  end

  def invoice_count_by_merchant
    sales_engine.merchants.all.map do |merchant|
      merchant.invoices.length
    end.sort
  end

  def find_day_of_week(date)
    date.strftime("%A")
  end

  def group_invoices_by_day
    sales_engine.invoices.all.group_by do |invoice|
      find_day_of_week(invoice.created_at)
    end
  end

  def group_invoices_by_day_count
    hash = group_invoices_by_day
    hash.each do | day, invoices |
      hash[day] = invoices.length
    end
  end

  def average_invoices_per_day
    average(group_invoices_by_day_count.values).round(2)
  end

  def group_invoices_status
    sales_engine.invoices.all.group_by do |invoice|
      invoice.status
    end
  end

  def sum(array)
    array.reduce(0) { |sum, item| sum + item }
  end

  def average(array)
    sum(array)/array.length.to_f
  end

  def standard_deviation(array)
    result = array.reduce(0) do |sum, item|
      sum + (item - average(array))**2
    end/(array.length - 1).to_f
    Math.sqrt(result).round(2)
  end

  def threshold(array, num_std_devs)
    average(array) + num_std_devs * standard_deviation(array)
  end

end

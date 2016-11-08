require_relative './sales_engine'
require 'bigdecimal'
require 'bigdecimal/util'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    (sales_engine.all_items.to_f / sales_engine.all_merchants.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    sqr_differences = sales_engine.merchants.all.map do |merchant|
      (merchant.items.length - average_items_per_merchant)** 2
    end
    Math.sqrt(sqr_differences.reduce(:+) / sales_engine.merchants.all.count).round(2)
  end


  def merchants_with_high_item_count
    threshold = (average_items_per_merchant_standard_deviation +
    average_items_per_merchant)
    sales_engine.merchants.all.reduce([]) do |result, merchant|
      result << merchant if merchant.items.count > threshold
      result
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_items = sales_engine.items.find_all_by_merchant_id(merchant_id)
    total = merchant_items.reduce(0) do |result, item|
      result += item.unit_price
      result
    end
    (total / merchant_items.count).to_d.round(2)
  end

  def average_average_price_per_merchant
    total_average = sales_engine.merchants.all.reduce(0) do |result, merchant|
      result += average_item_price_for_merchant(merchant.id)
      result
    end
    (total_average / sales_engine.merchants.all.count).floor(2)
  end

  def golden_items
    threshold = (average_item_price + average_item_price_standard_deviation * 2)
    sales_engine.items.all.reduce([]) do |result, item|
      result << item if item.unit_price > threshold
      result
    end
  end

  def average_invoices_per_merchant
    (sales_engine.all_invoices.to_f / sales_engine.all_merchants.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    sqr_differences = sales_engine.merchants.all.map do |merchant|
      (merchant.invoices.length - average_invoices_per_merchant)** 2
    end
    Math.sqrt(sqr_differences.reduce(:+) /
    sales_engine.merchants.all.count).round(2)
  end

  def top_merchants_by_invoice_count
    threshold = (average_invoices_per_merchant +
    average_invoice_standard_deviation * 2)
    sales_engine.merchants.all.reduce([]) do |result, merchant|
      result << merchant if merchant.invoices.count > threshold
      result
    end
  end

  def bottom_merchants_by_invoice_count
    threshold = (average_invoices_per_merchant -
    average_invoice_standard_deviation * 2)
    sales_engine.merchants.all.reduce([]) do |result, merchant|
      result << merchant if merchant.invoices.count < threshold
      result
    end
  end


  def top_days_by_invoice_count
    above_std_deviation = sorted_by_day_pairs.find_all do |day, value|
      value if value > average_invoices_per_day + standard_deviation_for_days
    end
    above_std_deviation.map { |pair| pair[0] }
  end

  def invoice_status(status)
    relevant_invoices = sales_engine.invoices.find_all_by_status(status)
    fraction = relevant_invoices.count.to_f / sales_engine.invoices.all.count
    (fraction * 100).round(2)
  end

  def total_revenue_by_date(date)
    sales_engine.invoices.all.reduce(0) do |result, invoice|
      if invoice.created_at.to_s.split(" ")[0].eql?(date.to_s.split[0])
        result +=  total_invoice_items_revenue(result, invoice)
      end
      result
    end.to_d.round(2)
  end

  def revenue_by_merchant(merchant_id)
    sales_engine.merchants.find_invoices_by_merchant_id(merchant_id).reduce(0) do |result, invoice|
      result +=  total_invoice_items_revenue(result, invoice)
      result
    end.to_d.round(2)
  end

  private
  def grouped_invoices_by_day
    sales_engine.invoices.all.group_by do |invoice|
      invoice.created_at.strftime("%A")
    end
  end

  def invoices_per_day
    grouped_invoices_by_day.values.map { |day| day.count}
  end

  def invoices_sorted_by_day
    grouped_invoices_by_day.keys.zip(invoices_per_day)
  end

  def sorted_by_day_pairs
    invoices_sorted_by_day.inject({}) do |result, pair|
      result[pair[0]] = pair[1]
      result
    end
  end

  def average_invoices_per_day
    sales_engine.invoices.all.count / 7
  end

  def squared_differences
    invoices_per_day.map do |total_per_day|
      (total_per_day - (sales_engine.invoices.all.count / 7))** 2
    end
  end

  def squared_differences_mean
    squared_differences.reduce(:+) / 7
  end

  def standard_deviation_for_days
    Math.sqrt(squared_differences_mean).round
  end

  def total_invoice_items_revenue(result, invoice)
    invoice.invoice_items.reduce(0) do |result, invoice_item|
      result += invoice_item.unit_price * invoice_item.quantity
      result
    end
  end

  def average_item_price_standard_deviation
    average = average_item_price
    sq_differences = sales_engine.items.all.map do |item|
      (item.unit_price - average)** 2
    end
    Math.sqrt(sq_differences.reduce(:+) / sales_engine.items.all.count).round(2)
  end

  def average_item_price
    item_prices = sales_engine.items.all.map { |item| item.unit_price }
    (item_prices.reduce(:+) / item_prices.count)
  end

  def average_invoice_standard_deviation
    average = average_invoice_count
    sqr_differences = sales_engine.merchants.all.map do |merchant|
      (merchant.invoices.count - average)** 2
    end.reduce(:+)
    Math.sqrt(sqr_differences / sales_engine.merchants.all.count).round(2)
  end

  def average_invoice_count
    invoice_count = sales_engine.merchants.all.map do |merchant|
      merchant.invoices.count
    end
    (invoice_count.reduce(:+) / invoice_count.count)
  end
end

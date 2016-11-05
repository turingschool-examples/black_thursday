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
    mean = sales_engine.merchants.all.map { |merchant| (merchant.items.length - average_items_per_merchant)** 2 }
    Math.sqrt(mean.reduce(:+) / sales_engine.merchants.all.count).round(2)
  end


  def merchants_with_high_item_count
    threshold = (average_items_per_merchant_standard_deviation + average_items_per_merchant)
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
    total_average_price = sales_engine.merchants.all.reduce(0) do |result, merchant|
      result += average_item_price_for_merchant(merchant.id)
      result
    end
    (total_average_price / sales_engine.merchants.all.count).floor(2)
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
    mean = sales_engine.merchants.all.map { |merchant| (merchant.invoices.length - average_invoices_per_merchant)** 2 }
    Math.sqrt(mean.reduce(:+) / sales_engine.merchants.all.count).round(2)
  end

  def top_merchants_by_invoice_count
    threshold = (average_invoices_per_merchant + average_invoice_standard_deviation * 2)
    sales_engine.merchants.all.reduce([]) do |result, merchant|
      result << merchant if merchant.invoices.count > threshold
      result
    end
  end

  def bottom_merchants_by_invoice_count
    threshold = (average_invoices_per_merchant - average_invoice_standard_deviation * 2)
    sales_engine.merchants.all.reduce([]) do |result, merchant|
      result << merchant if merchant.invoices.count < threshold
      result
    end
  end

  def invoice_status(status)
    relevant_invoices = sales_engine.invoices.find_all_by_status(status)
    fraction = relevant_invoices.count.to_f / sales_engine.invoices.all.count
    (fraction * 100).round(2)
  end

  # def top_days_by_invoice_count
  #   # threshold = (average_invoice_per_day_standard_deviation + (sales_engine.invoices.all.count / 7))
  #   @invoices_grouped_by_day = sales_engine.invoices.all.group_by { |invoice| invoice.created_at.strftime("%A") }
  #   invoices_per_day
  #   # total_invoices = invoices_grouped_by_day.select do |result, num_of_invoices|
  #   #   result if num_of_invoices > threshold
  #   # end.compact
  #   # invoices_per_day > threshold
  #   # #
  #   # #we need to know which days are more than one standard deviation away from the mean
  #   # average = total_invoices.reduce(:+) / 7
  #   # mean = sales_engine.invoices.all.map { |invoice| (invoice - average)** 2 }
  #   # Math.sqrt(mean.reduce(:+) / sales_engine.items.all.count).round(2)
  # end

private

  def average_item_price_standard_deviation
    average = average_item_price
    mean = sales_engine.items.all.map { |item| (item.unit_price - average)** 2 }
    Math.sqrt(mean.reduce(:+) / sales_engine.items.all.count).round(2)
  end

  def average_item_price
    item_prices = sales_engine.items.all.map { |item| item.unit_price }
    (item_prices.reduce(:+) / item_prices.count)
  end

  def average_invoice_standard_deviation
    average = average_invoice_count
    squared_differences = sales_engine.merchants.all.map { |merchant| (merchant.invoices.count - average)** 2 }.reduce(:+)
    Math.sqrt(squared_differences / sales_engine.merchants.all.count).round(2)
  end

  def average_invoice_count
    invoice_count = sales_engine.merchants.all.map { |merchant| merchant.invoices.count }
    (invoice_count.reduce(:+) / invoice_count.count)
  end

  # def invoices_per_day
  #   x = @invoices_grouped_by_day.values.map do |invoices_for_given_day|
  #     invoices_for_given_day.count
  #   end
  # end

  # def average_invoice_per_day_standard_deviation
  #   average = invoices_per_day / 7
  #
  # end
end

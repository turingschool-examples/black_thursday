require_relative 'sales_engine'
require 'bigdecimal'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    sum = items_per_merchant.reduce(:+)
    (sum.to_f / items_per_merchant.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    sum_of_differences = items_per_merchant.reduce(0) do |memo, item|
      memo += (item - average_items_per_merchant) ** 2
      memo
    end
    divided = sum_of_differences / (items_per_merchant.count - 1)
    Math.sqrt(divided).round(2)
  end

  def merchants_with_high_item_count
    mean = average_items_per_merchant
    std_dev = average_items_per_merchant_standard_deviation
    merchants.values.find_all do |merchant|
      merch_count = @sales_engine.items.find_all_by_merchant_id(merchant.id).count
      merch_count > (std_dev + mean)
    end
  end

  def average_item_price_for_merchant(id)
    @sales_engine.merchants.find_by_id(id)
    merchant_items = items.values.find_all do |item|
      item.merchant_id == id
    end
    prices = merchant_items.map(&:unit_price)
    (prices.reduce(:+) / prices.count).round(2)
  end

  def average_average_price_per_merchant
    merchant_averages = merchants.values.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    (merchant_averages.reduce(:+) / merchant_averages.count).round(2)
  end

  def average_item_cost
    total_cost = 0.0
    items.values.each do |item|
      total_cost += item.unit_price_to_dollars
    end
    (total_cost / items.count).round(2)
  end

  def average_price_per_merchant_standard_deviation
    average = average_average_price_per_merchant
    times = price_count.map do |price|
      (price - average) ** 2
    end
    deviation(times)
  end

  def mean_finder(item_array)
    mean = 0.0
    item_array.each { |count| mean += count }
    return 0 if item_array.length.zero?
    mean / item_array.length
  end

  def standard_devation(mean, item_array)
    std_dev = 0.0
    item_array.each do |item|
      std_dev += (item.unit_price_to_dollars - mean)**2
    end
    std_dev /= item_array.length - 1
    Math.sqrt(std_dev)
  end

  def golden_items
    item_array = items.values
    price_array = item_array.map(&:unit_price)
    mean = mean_finder(price_array)
    std_dev = standard_devation(mean, item_array)
    item_array.find_all { |item| item.unit_price > ((std_dev * 2) + mean) }
  end

  def average_invoices_per_merchant
    invoices = @sales_engine.invoices.contents.count.to_f
    merchants = @sales_engine.merchants.merchants.count.to_f
    (invoices / merchants).round(2)
  end

  def average_items_price_standard_deviation
    standard_deviation(all_item_prices, average_average_price_per_merchant)
  end

  def invoices
    sales_engine.invoices.all
  end

  def items
    @items ||= @sales_engine.items.contents
  end

  def merchants
    @merchants ||= @sales_engine.merchants.merchants
  end

  private

  def items_per_merchant
    @items_per_merchant ||= items.values.group_by(&:merchant_id).values.map(&:count)
  end
end

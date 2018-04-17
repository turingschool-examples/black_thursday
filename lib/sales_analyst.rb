require_relative 'sales_engine'
require 'bigdecimal'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    sum = items_per_merchant.reduce(:+)
    sum.to_f / items_per_merchant.count
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
     prices = merchant_items.map do |item|
      item.unit_price_to_dollars
    end
    BigDecimal(prices.reduce(:+) / prices.count, 2)
  end

  def average_average_price_per_merchant
    merchant_averages = merchants.values.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    (merchant_averages.reduce(:+) / merchant_averages.count)
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

  def deviation(numbers)
    Math.sqrt(numbers.reduce(:+) / (numbers.count - 1)).round(2)
  end

  def price_count
    items.values.map(&:unit_price_to_dollars)
  end

  def golden_items
    average = average_price_per_merchant_standard_deviation
    items.values.map do |item|
      item if item.unit_price_to_dollars >= ((average * 2) + average_price)
    end
  end

  private

  def items
    @items ||= @sales_engine.items.contents
  end

  def merchants
    @merchants ||= @sales_engine.merchants.merchants
  end

  def items_per_merchant
    @items_per_merchant ||= items.values.group_by(&:merchant_id).values.map(&:count)
  end
end

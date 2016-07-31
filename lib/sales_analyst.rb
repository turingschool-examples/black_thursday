require_relative 'sales_engine'
require 'pry'

class SalesAnalyst
  attr_reader :engine

  def initialize(sales_engine)
    @engine = sales_engine
  end

  def average_items_per_merchant
    ans = engine.items_per_merchant.reduce(&:+) / engine.total_merchants.to_f
    ans.round(2)
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    segment = engine.items_per_merchant.reduce(0) do |sum, num|
      sum += (num.to_f - average) ** 2
    end
    Math.sqrt(segment / (engine.total_merchants - 1)).round(2)
  end

  def merchants_with_high_item_count
    min_items = average_items_per_merchant +
                average_items_per_merchant_standard_deviation
    engine.merchants_with_item_count_over_n(min_items)
  end

  def average_item_price_for_merchant(id)
    merchant_items = engine.find_all_items_by_merchant_id(id)
    price_sum = merchant_items.reduce(0) do |sum, item|
      sum += item.unit_price
    end
    (price_sum / merchant_items.length).round(2)
  end

  def average_average_price_per_merchant
    average_price_sum = engine.merchants.all.reduce(0) do |sum, merc|
      sum += average_item_price_for_merchant(merc.id)
    end
    (average_price_sum / engine.total_merchants).round(2)
  end

  def average_item_price
    sum_all_unit_prices = engine.all_items.reduce(0) do |sum, item|
      sum += item.unit_price
    end
    sum_all_unit_prices / engine.total_items.to_f
  end

  def average_item_price_standard_deviation
    average = average_item_price
    segment = engine.all_items.reduce(0) do |sum, item|
      sum += (item.unit_price - average) ** 2
    end
    Math.sqrt(segment / (engine.total_items - 1)).round(2)
  end

  def golden_items
    min_price = average_item_price + average_item_price_standard_deviation * 2
    engine.items_with_price_over_n(min_price)
  end
end

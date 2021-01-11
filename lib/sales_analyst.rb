require 'csv'
require 'pry'
require 'bigdecimal'
require_relative './sales_engine'
require_relative './standard_deviation'

class SalesAnalyst
  extend StandardDeviation

  attr_reader :engine
  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    (engine.items.all.count.to_f / engine.merchants.all.count).round(2)
  end

  def reduce_shop_items
    engine.merchants.all.reduce({}) do |memo, merchant|
      memo[merchant.id] = []
      engine.items.all.each do |item|
        if item.merchant_id == merchant.id
          memo[merchant.id] << item.unit_price
        end
      end
      memo
    end
  end

  def number_of_items
    thing = reduce_shop_items.map{|merchant, item| item.count }
  end

  def average_items_per_merchant_standard_deviation
    numbers = number_of_items.extend(StandardDeviation)
    numbers.standard_deviation
  end

  def average_by_average_merchant_deviation
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def merchant_names_with_high_item_count
    deviation = average_by_average_merchant_deviation
    array = reduce_shop_items.map do |shop, item|
      if item.count >= deviation
        shop
      end
    end
    array.uniq[1..-1]
  end

  def merchants_with_high_item_count
    merchant_array = []
    merchant_names_with_high_item_count.each do |merchant_name|
      engine.merchants.all.each do |merchant_object|
        merchant_array << merchant_object if merchant_object.id == merchant_name
      end
    end
    merchant_array
  end

  def average_item_price_for_merchant(merchant_id)
    item_shop = reduce_shop_items.extend(StandardDeviation)
    (item_shop[merchant_id].sum / item_shop[merchant_id].count).round(2)
  end

  def average_average_price_per_merchant
    average_price = reduce_shop_items
    prices = engine.merchants.all.map do |merchant|
      (average_price[merchant.id].sum / average_price[merchant.id].count)
    end
    BigDecimal(prices.sum / average_price.keys.count).round(2)
  end

  def second_deviation_above_unit_price
    unit_price_array = reduce_shop_items.values.flatten
    unit_price_array = unit_price_array.extend(StandardDeviation)
    (average_average_price_per_merchant) + (unit_price_array.standard_deviation * 2)
  end

  def golden_items
    golden = []
    deviation = second_deviation_above_unit_price
    engine.items.all.each do |item|
      golden << item if item.unit_price > deviation
    end
    golden
  end
end

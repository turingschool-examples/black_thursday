require 'csv'
require 'pry'
require 'descriptive_statistics'
require_relative './sales_engine'

class SalesAnalyst

  attr_reader :engine
  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    (engine.items.all.count.to_f / engine.merchants.all.count).round(2)
  end

  def reduce_shop_items
    engine.merchants.all.reduce({}) do |memo, merchant|
      memo[merchant.name] = []
      engine.items.all.each do |item|
        if item.merchant_id == merchant.id
          memo[merchant.name] << item.name
        end
      end
      memo
    end
  end

  def number_of_items
    reduce_shop_items.map do |merchant, item|
      item.count
    end
  end

  def item_sum
    BigDecimal(number_of_items.reduce(0) {|memo, item| memo + item})
  end

  def mean
    BigDecimal(item_sum / reduce_shop_items.length)
  end

  def sample_variance
    new_sum = number_of_items.reduce(0) do |memo, item|
      memo + (item - mean) ** 2
    end

    new_sum / (reduce_shop_items.length - 1).to_f
  end

  def standard_deviation
    Math.sqrt(sample_variance)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation.round(2)
  end
  #
  # def average_items_per_merchant_standard_deviation
  #   number_of_items = reduce_shop_items.map do |merchant, item|
  #     item.count
  #   end
  #   require "pry"; binding.pry
  #   number_of_items.standard_deviation.round(2)
  # end

  def average_by_average_merchant_deviation
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def merchant_names_with_high_item_count
    shops = []
    item_count_array = reduce_shop_items.select do |shop, item|
      shops << shop if item.count >= average_by_average_merchant_deviation
    end
    shops
  end

  def merchants_with_high_item_count
    merchant_array = []
    merchant_names_with_high_item_count.each do |merchant_name|
      engine.merchants.all.each do |merchant_object|
        merchant_array << merchant_object if merchant_object.name == merchant_name
      end
    end
    merchant_array
  end

  def reduce_shop_items_by_unit_price_average
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

  def average_item_price_for_merchant(merchant_id)
    average_price = reduce_shop_items_by_unit_price_average
    average_price[merchant_id].mean.round(2)
  end

  def average_average_price_per_merchant
    average_price = reduce_shop_items_by_unit_price_average
    average_average = []
    engine.merchants.all.map do |merchant|
      average_average << average_price[merchant.id].mean
    end
    average_average.mean.round(2)
  end

  def unit_price_array
    average_price = reduce_shop_items_by_unit_price_average
    unit_deviation = []
    average_price.values.each do |unit_price_array|
      unit_deviation << unit_price_array
    end
    unit_deviation.flatten
  end

  def second_deviation_above_unit_price
    (average_average_price_per_merchant) + (unit_price_array.standard_deviation * 2)
  end

  def golden_items
    golden = []
    engine.items.all.each do |item|
      golden << item if item.unit_price > second_deviation_above_unit_price
    end
    golden
  end
end

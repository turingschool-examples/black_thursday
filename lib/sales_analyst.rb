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

  def average_items_per_merchant_standard_deviation
    number_of_items = reduce_shop_items.map do |merchant, item|
      item.count
    end
    number_of_items.standard_deviation.round(2)
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
    # require "pry"; binding.pry
  end

  def average_item_price_for_merchant(merchant_id)
    #   number_of_items = reduce_shop_items_by_unit_price_average.map do |merchant, item|
    #     item.count
    #   end
    #   number_of_items.mean.round(2)
    # end
    average_price = reduce_shop_items_by_unit_price_average
    average_price[merchant_id]
    require "pry"; binding.pry
  end
end

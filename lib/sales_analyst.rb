require 'bigdecimal'
require 'bigdecimal/util'

class SalesAnalyst
  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    (engine.items.all.length.to_f / engine.merchants.all.length.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    mean = engine.merchants.all.map do |merchant|
      (merchant.items.length - average_items_per_merchant)**2
    end
    Math.sqrt(mean.sum/(engine.merchants.all.count-1)).round(2)
  end

  def merchants_with_high_item_count
    count = average_items_per_merchant + average_items_per_merchant_standard_deviation
    engine.merchants.all.select do |merchant|
      merchant.items.count > count
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items = engine.find_all_items_per_merchant(merchant_id)
    item_prices = items.map do |item|
      item.unit_price
    end
    (item_prices.sum/items.length).to_d.round(2)
  end

  def average_average_price_per_merchant
    averages = engine.merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    (averages.sum/engine.merchants.all.length).floor(2)
  end

  # def golden_items ==== TO DO
  #   count = average_items_per_merchant + (average_items_per_merchant_standard_deviation*2)
  #   items = engine.merchants.all.map do |merchant|
  #     average_item_price_for_merchant(merchant.id) > count
  #   end
  # end
end

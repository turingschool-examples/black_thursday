
require 'bigdecimal'
require_relative 'sales_engine.rb'

class SalesAnalyst
  attr_reader :engine
  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    all_merchants = merchant_collector.length
    total_items = item_collector.length
    (total_items.to_f / all_merchants).round(2)
  end

  # def average_items_per_merchant
  #   all_merchants = merchant_collector
  #   total_items = all_merchants.map do |merchant|
  #     merchant.items.length
  #   end.sum.to_f
  #   (total_items / all_merchants.length).round(2)
  # end



  # def average_items_per_merchant_standard_deviation
  #   merchant_collector.map do |merchant|
  #     merchant.items.length
  #   end.stdev.round(2)
  # end

  # def merchants_with_high_item_count
  #   avg_item_std_dev = average_items_per_merchant_standard_deviation
  #   merchant_collector.map do |merchant|
  #     merchant if (merchant.items.length - avg_item_std_dev) > avg_item_std_dev
  #   end.compact
  # end

  def average_item_price_for_merchant(merch_id)
    merch_items = engine.merchants.find_by_id(merch_id).items
    merch_items.map do |item|
      item.unit_price
    end.sum / merch_items.length
  end

  def average_average_price_per_merchant
    all_merchants = merchant_collector
    all_merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end.sum / all_merchants.length
  end

  def golden_items
    all_items = item_collector
    price_stdev = price_standard_deviation
    all_items.map do |item|
      item if (item.unit_price.truncate - price_stdev) > (2 * price_stdev)
    end.compact
  end

  def merchant_collector
    engine.merchants.all
  end


  def item_collector
    engine.items.all
  end

  # def price_standard_deviation
  #   item_collector.map do |item|
  #     item.unit_price.truncate
  #   end.stdev.round(2)
  # end
end

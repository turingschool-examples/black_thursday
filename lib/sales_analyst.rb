require 'ruby_native_statistics'
require 'bigdecimal'
require_relative 'sales_engine.rb'

class SalesAnalyst
  attr_reader :engine
  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    all_merchants = merchant_collector
    total_items = all_merchants.map do |merchant|
      merchant.items.length
    end.sum.to_f
    (total_items / all_merchants.length).round(2)
  end

  def average_items_per_merchant_standard_deviation
    merchant_collector.map do |merchant|
      merchant.items.length
    end.stdev.round(2)
  end

  def merchants_with_high_item_count
    avg_item_std_dev = average_items_per_merchant_standard_deviation
    merchant_collector.map do |merchant|
      merchant if (merchant.items.length - avg_item_std_dev) > 1
    end.compact
  end

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

  def merchant_collector
    engine.merchants.find_all_by_name('')
  end
end

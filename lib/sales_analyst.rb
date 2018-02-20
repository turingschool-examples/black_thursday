require 'ruby_native_statistics'
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
    this = average_items_per_merchant_standard_deviation
    merchant_collector.map do |merchant|
      merchant if (merchant.items.length - this) > 1
    end.compact
  end

  def merchant_collector
    engine.merchants.find_all_by_name('')
  end
end

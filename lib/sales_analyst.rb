
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

  def standard_deviation(mean, data_set)
    squared_distance_sum = data_set.map do |data_point|
      (data_point - mean.to_f.abs) ** 2
    end.sum

    ((squared_distance_sum/data_set.length) ** 0.5).round(2)
  end

  def find_mean(data_set)
    total = data_set.inject(0.0) do |sum, data_point|
      sum + data_point
    end

    total / data_set.length
  end

  def average_items_per_merchant_standard_deviation
    merchant_item_array = merchant_collector.map do |merchant|
      merchant.items.length
    end
    standard_deviation(average_items_per_merchant, merchant_item_array)
  end

  def merchants_with_high_item_count
    avg_item_std_dev = average_items_per_merchant_standard_deviation
    merchant_collector.map do |merchant|
      merchant if (merchant.items.length - avg_item_std_dev) > avg_item_std_dev
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

  def price_standard_deviation
    item_price_array = item_collector.map do |item|
      item.unit_price
    end

    mean = find_mean(item_price_array)
    standard_deviation(mean, item_price_array)
  end
end

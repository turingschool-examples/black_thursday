require 'CSV'
require 'bigdecimal'
require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average(data)
    data.sum / data.size.to_f
  end

  def standard_deviation(sample_size)
    Math.sqrt(sample_size.sum do |sample|
      (sample - average(sample_size)) ** 2 / (sample_size.size - 1)
    end).round(2)
  end

  def items_per_merchant
    all_items = @engine.items
    all_merchants = @engine.merchants
    all_merchants.all.map do |merchant|
      all_items.find_all_by_merchant_id(merchant.id).count
    end
  end

  def average_items_per_merchant
    average(items_per_merchant).round(2)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(items_per_merchant)
  end

  def high_item_count
    standard_deviation(items_per_merchant) + average_items_per_merchant
  end

  def merchants_with_high_item_count
    all_items = @engine.items
    all_merchants = @engine.merchants.all
    all_merchants.map do |merchant|
      if all_items.find_all_by_merchant_id(merchant.id).count >= high_item_count
        merchant
      end
    end.compact
  end

  def average_item_price_for_merchant(merchant_id)
    all_items = @engine.items
    unit_prices = all_items.find_all_by_merchant_id(merchant_id).map do |item|
      item.unit_price
    end
    average(unit_prices).round(2)
  end

  def average_average_price_per_merchant
    all_merchants = @engine.merchants.all
    all_merchant_averages = all_merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    average(all_merchant_averages).round(2)
  end

  def golden_items
    all_items_unit_prices = @engine.items.all.map { |item| item.unit_price }
    stan_div = standard_deviation(all_items_unit_prices) * 2
    avg = average(all_items_unit_prices)
    @engine.items.all.find_all do |item|
      item.unit_price >= (stan_div + avg)
    end
  end
end

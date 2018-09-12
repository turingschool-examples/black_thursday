require_relative './merchant_repository'
require_relative './item_repository'
require 'pry'

class SalesAnalyst

  def initialize(sales_engine)
    @se = sales_engine
  end

  def average_items_per_merchant
    (@se.items.all.count.to_f/@se.merchants.all.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    hash = Hash.new(0)
    @se.items.all.each do |item|
      hash[item.merchant_id] += 1
    end
    differences_squared = hash.values.map do |value|
      (value-average_items_per_merchant)**2
    end
    sum = differences_squared.inject(0) do |sum, num|
      sum + num
    end
    sum_div = sum/hash.count
    Math.sqrt(sum_div).round(2)
  end

  def merchants_with_high_item_count
    hash = Hash.new(0)
    @se.items.all.each do |item|
      hash[item.merchant_id] += 1
    end
    threshold = average_items_per_merchant +
                average_items_per_merchant_standard_deviation

    merchant_ids = hash.find_all do |key, value|
      value > threshold
    end

    merchant_ids.map do |id, value|
      @se.merchants.find_by_id(id)
    end
  end

  def average_item_price_for_merchant(id)
    prices = []
    @se.items.all.each do |item|
      if item.merchant_id == id
        prices << item.unit_price
      end
    end
    sum = prices.inject(0) do |sum, price|
      sum + price
    end
    sum/prices.count
  end

  def average_average_price_per_merchant
    sum = @se.merchants.all.inject(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id)
    end
    (sum/@se.merchants.all.count).round(2)
  end

  def golden_items

  end


end

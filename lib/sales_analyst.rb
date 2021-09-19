require 'bigdecimal/util'
# frozen_string_literal: true

# require 'csv'
require 'bigdecimal/util'
# require_relative './items'
# require_relative './merchants'
# require_relative './sales_engine'

class SalesAnalyst
  def initialize(items, merchants)
    @items = items
    @merchants = merchants
    @avgavg = []
  end

  def average_items_per_merchant
    (@items.all.count.to_f / @merchants.all.count).round(2)
  end

  def items_per_merchant
    @merchants.all.map do |merchant|
      @items.find_all_by_merchant_id(merchant.id).length
    end
  end

  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    x = items_per_merchant.sum(0.0) { |element| (element - mean)**2 }
    variance = x / (items_per_merchant.count - 1)
    standard_deviation = Math.sqrt(variance).round(2)
  end

  def merchants_with_high_item_count
    test = []
    @merchants.all.each do |merchant|
      if @items.find_all_by_merchant_id(merchant.id).length > (average_items_per_merchant_standard_deviation * 2)
        test << merchant
      end
    end
    test
  end

  def average_item_price_for_merchant(id)
    items_by_merchant = []
    @items.all.each do |item|
      if item.merchant_id == id
        items_by_merchant << item.unit_price
      end
    end
    (items_by_merchant.sum/items_by_merchant.count).to_d.round(2)
  end

  def average_average_price_per_merchant
    @merchants.all.each do |merchant|
      @avgavg << average_item_price_for_merchant(merchant.id)
    end
    (@avgavg.sum / @merchants.all.count).to_d.round(2)
  end

  def item_price_standard_dev
    avg_item_price = @items.all.map do |item|
      item.unit_price
    end
    mean = (avg_item_price.sum / @items.all.count)
    sum = avg_item_price.sum(0.0) { |element| (element - mean) ** 2 }
    variance = sum / (@items.all.count - 1)
    standard_deviation = Math.sqrt(variance).round(2)
  end

  def golden_items
    expensive_items = []
    @items.all.each do |item|
      if item.unit_price > (item_price_standard_dev * 2)
        expensive_items << item
      end
    end
    expensive_items
  end
end

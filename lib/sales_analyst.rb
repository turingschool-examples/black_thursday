# frozen_string_literal: true

require 'bigdecimal'
require 'bigdecimal/util'
class SalesAnalyst
  attr_reader :items,
              :merchants

  def initialize(items, merchants)
    @items = items
    @merchants = merchants
  end

  def average_items_per_merchant
    (@items.all.size.to_f / @merchants.all.size).round(2)
  end

  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    sum = array_of_items_per_merchant.sum(0.0) { |element| (element - mean) ** 2 }
    variance = sum / (@merchants.all.size - 1)
    return Math.sqrt(variance).round(2)
  end

  def array_of_items_per_merchant
    @merchants.all.map do |merchant|
      @items.find_all_by_merchant_id(merchant.id).size
    end
  end

  def merchants_with_high_item_count
    result = avg_plus_std_dev
    @merchants.all.select do |merchant|
      @items.find_all_by_merchant_id(merchant.id).size > result
    end
  end

  def avg_plus_std_dev
    (average_items_per_merchant + average_items_per_merchant_standard_deviation).to_i
  end

  def average_item_price_for_merchant(merchant_id)
    sum = @items.find_all_by_merchant_id(merchant_id).sum do |item|
      sum = 0 if sum.nil?
      item.unit_price.to_d(2)
      # should conversion to big decimal happen
      # in the item class??
    end
  end

  def average_average_price_per_merchant
    total_of_averages = @merchants.all.sum do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    total_of_averages / @merchants.all.size
  end

  def average_item_price
    sum_of_items = @items.all.sum(&:unit_price)
    sum_of_items / @items.all.size
  end

  def average_item_price_std_dev
    mean = average_item_price
    sum = array_of_items_price.sum(0.0) { |element| (element - mean) ** 2 }
    variance = sum / (@items.all.size - 1)
    return Math.sqrt(variance).round(2)
  end

  def array_of_items_price
    @items.all.map(&:unit_price)
  end

  def golden_items
    result = (average_item_price + (average_item_price_std_dev * 2))
    @items.all.select do |item|
      item.unit_price > result
    end
  end
end

require 'pry'
require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :items,
              :merchants

  def initialize(items, merchants)
    @items = items
    @merchants = merchants
  end

  def average_items_per_merchant
    (@items.all.count.to_f / @merchants.all.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    merchant_ids = find_all_merchant_ids
    items_from_each_merchant = get_number_of_items_from_merchants(merchant_ids)
    difference_squared = items_from_each_merchant.map do |number|
      (number - average_items_per_merchant) ** 2
    end
    summed_differences = difference_squared.inject(:+)
    sum = summed_differences / (items_from_each_merchant.count - 1)
    std_dev = Math.sqrt(sum).round(2)
  end

  def find_all_merchant_ids
    @merchants.all.map do |merchant|
      merchant.id
    end
  end

  def get_number_of_items_from_merchants(merchant_ids)
    merchant_ids.map do |merchant_id|
      @items.find_all_by_merchant_id(merchant_id).count
    end
  end

  def merchants_with_high_item_count
    high_item_indicator = average_items_per_merchant + average_items_per_merchant_standard_deviation
    high_seller_ids = find_all_merchant_ids.find_all do |merchant_id|
      @items.find_all_by_merchant_id(merchant_id).count >= high_item_indicator
    end
    high_seller_ids.map do |id|
      @merchants.find_by_id(id)
    end
  end

  def average_item_price_for_merchant(id)
    @items.find_all_by_merchant_id(id)
  end

end

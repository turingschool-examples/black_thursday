require_relative '../lib/sales_engine'
require 'pry'

class SalesAnalyst

  attr_reader :sales_engine

  def initialize(sales_engine_from_csv)
    @sales_engine = sales_engine_from_csv
  end

  def average_items_per_merchant
    (total_items/total_merchants).round(2)
  end

  def total_merchants
    sales_engine.merchants.count.to_f
  end

  def total_items
    sales_engine.items.count.to_f
  end

  def average_items_per_merchant_standard_deviation
    calculate_std_dev
  end

  def pull_all_merchant_ids
    @sales_engine.merchants.merchants.map do |merchant|
      merchant.id
    end
  end

  def find_items_per_merchant
    pull_all_merchant_ids.map do |merchant_id|
      @sales_engine.items.find_all_by_merchant_id(merchant_id).count
    end
  end

  def calculate_std_dev
    sum = find_items_per_merchant.reduce(0) do |result, merchant|
      squared_difference = (average_items_per_merchant - merchant) ** 2
      result + squared_difference
    end
    Math.sqrt(sum / (total_merchants-1)).round(2)
  end

  def merchants_and_item_count
    Hash[pull_all_merchant_ids.zip find_items_per_merchant]
  end

  def merchants_with_high_item_count
    high_item_count_merchant_ids.map do |merchant_id|
      @sales_engine.merchants.find_by_id(merchant_id)
    end
  end

  def high_item_count_merchant_ids
    merchants_and_item_count.map do |merchant_id,item_count|
      merchant_id if item_count > (average_items_per_merchant + calculate_std_dev)
    end.compact
  end

  def average_item_price_for_merchant(merchant_id)
    item_prices = @sales_engine.items.items.map do |item|
      item.unit_price if item.merchant_id == merchant_id
    end.compact
    (item_prices.sum/item_prices.length).round(2)
  end

  def average_average_price_per_merchant
    average_price = @sales_engine.items.items.reduce(0) do |result,item|
      result += item.unit_price
      result
    end/total_merchants
    average_price.round(2)
  end

  def golden_items
    # calculate_std_dev.find_all do |merchant|
    #   merchant ** 2

  end

end


# merchant_ids = pull_all_merchant_ids
# items_per_merchant = find_items_per_merchant
# merchants_index =[]
# items_per_merchant.each_with_index do |merchant,index|
#   merchants_index << index if (merchant > (average_items_per_merchant + calculate_std_dev))
# end
# @sales_engine.merchants.merchants.map do |merchant|
#   if
#   merchant.name
# end

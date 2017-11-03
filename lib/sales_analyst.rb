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

  def merchants_with_high_item_count
    find_items_per_merchant.find_all do |merchant|
      merchant > (average_items_per_merchant + calculate_std_dev)
    end
  end

  def golden_items
    # calculate_std_dev.find_all do |merchant|
    #   merchant ** 2
  
  end

end

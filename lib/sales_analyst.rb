require_relative '../lib/sales_engine'
require 'pry'

class SalesAnalyst
  attr_reader :sales_engine,
              :merchant

  include Math

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @merchant = merchant
  end

  def find_all_merchants
    sales_engine.merchants.all
  end

  def find_all_items
    sales_engine.items.all
  end

  def total_items_per_merchant(merchant_id)
    find_merchant(merchant_id).items.count
  end

  def average_items_per_merchant
    (find_all_items.length / find_all_merchants.length.to_f).round(2)
  end

  def sum_squares
    find_all_merchants.reduce(0) do |sum_squares, merchant|
      sum_squares += squared_difference_from_average(merchant.id)
      sum_squares
    end
  end

  def sum_squares_of_price_differences
    find_all_items.reduce(0) do |sum_squares, item|
      sum_squares += squared_difference_from_average_for_price(item)
      sum_squares
    end
  end

  def squared_difference_from_average(merchant_id)
    ((total_items_per_merchant(merchant_id) - average_items_per_merchant).abs.to_f) ** 2
  end

  def squared_difference_from_average_for_price(item)
    ((item.unit_price - average_item_price).abs.to_f) ** 2
  end

  def average_items_per_merchant_standard_deviation
    sqrt( (sum_squares / (find_all_merchants.length - 1))).round(2)
  end

  def average_price_standard_deviation
    sqrt( (sum_squares_of_price_differences / (find_all_items.length - 1))).round(2)
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = find_merchant(merchant_id)
    return nil if merchant == nil || merchant.items == []

    (total_item_price_for_merchant(merchant) /
    merchant.items.length).
    round(2)
  end

  def find_merchant(merchant_id)
    sales_engine.merchants.find_by_id(merchant_id)
  end

  def total_item_price_for_merchant(merchant)
    merchant.items.reduce(0) do |total, item|
      total += item.unit_price
      total
    end
  end

  def average_average_price_per_merchant
    all_merchants = find_all_merchants
    active_merchants = find_active_merchants(all_merchants)
    return nil if all_merchants == [] || active_merchants == []

    (total_item_price_for_active_merchants(active_merchants) /
    active_merchants.length).
    floor(2)
  end

  def find_active_merchants(all_merchants)
    all_merchants.find_all do |merchant|
      average_item_price_for_merchant(merchant.id) != nil
    end
  end

  def total_item_price_for_active_merchants(active_merchants)
    active_merchants.reduce(0) do |total, merchant|
      total += average_item_price_for_merchant(merchant.id)
      total
    end
  end

  def merchants_with_high_item_count
    all_merchants = find_all_merchants
    avg_items = average_items_per_merchant
    std_dev = average_items_per_merchant_standard_deviation
    all_merchants.find_all do |merchant|
      total_items_per_merchant(merchant.id) > (avg_items + std_dev)
    end
  end

  def golden_items
    all_items = find_all_items
    avg_price = average_item_price
    std_dev = average_price_standard_deviation
    all_items.find_all do |item|
      item.unit_price > (avg_price + (std_dev * 2))
    end
  end

  def average_item_price
    total_price = find_all_items.reduce(0) do |total, item|
      total += item.unit_price
      total
    end
    (total_price / find_all_items.length).floor(2)
  end

end

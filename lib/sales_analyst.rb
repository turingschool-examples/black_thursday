require 'csv'
require 'pry'
require 'bigdecimal'
require './lib/sales_engine'
require './lib/calculations_module'

class SalesAnalyst
  include Calculations

  attr_reader :se,
              :merchant_item_array

  def initialize(sales_engine)
    @se = sales_engine
    @merchant_item_array = []
  end

  def average_items_per_merchant
    all_items = se.items.all.length.to_f
    all_merchants = se.total_merchants.to_f
    (all_items/all_merchants).round(2)
  end

  def create_all_merchant_ids
    se.merchants.all.map do |merchant|
      merchant.id
    end
  end

  def average_items_per_merchant_standard_deviation
    all_ids = create_all_merchant_ids
    array = all_ids.map do |id|
      items_per_merchant(id)
    end
    mean(array)
  end

  def items_per_merchant(merchant_id)
    merchant = se.merchants.find_by_id(merchant_id)
    @merchant_item_array << merchant.items
    merchant_item_array.length
  end

  def average_item_price_per_merchant(merchant_id)
    items = se.items.find_all_by_merchant_id(merchant_id)
    aggregate_price = items.map do |item|
      item.unit_price 
    end.reduce(:+).to_f
    (aggregate_price/items.count).round(2)
  end
    
  def average_price_per_item
    all_merchants = se.merchants.all
    sum = all_merchants.map do |merchant|
      average_item_price_per_merchant(merchant.id)
    end.reduce(:+).to_f
    (sum/all_merchants.length).round(2)
  end

  def golden_items
    all_items = se.items.all
    array_of_prices = all_items.map do |item|
      item.unit_price
    end
    gold = price_threshold(array_of_prices, 2)
    all_items.find_all do |gold_items| 
      gold_items.unit_price > gold
    end
  end
end

 
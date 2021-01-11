require 'pry'
require_relative './sales_engine'
require_relative './mathable'
class SalesAnalyst
  include Mathable
  attr_reader :sales_engine
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end
  def total_items
    sales_engine.count_items
  end
  def total_merchants
    sales_engine.count_merchants
  end
  def average_item_price
    sales_engine.average_item_price
  end
  def average_items_per_merchant
    average_stuff(total_items.to_f, total_merchants)
  end
  def items_per_merchant
    sales_engine.items
  end
  def average_item_price
    sales_engine.average_item_price
  end
  def item_price_standard_deviation
    average = average_item_price
    total = sales_engine.pass_item_array.sum do |item|
      (average - item.unit_price_to_dollars)**2
      end
    square_something(total, total_items)
  end
  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    total = 0
    sales_engine.merchant_hash_item_count.each do |key, value|
      total += (average - value)**2
    end
    square_something(total, total_merchants)
  end
  def merchants_with_high_item_count
    greater_than_sd = average_items_per_merchant + average_items_per_merchant_standard_deviation
    merchants = []
    sales_engine.merchant_hash_item_count.find_all do |merchant_id, count|
      if count >= greater_than_sd
        merchants << sales_engine.find_by_merchant_id(merchant_id)
      end
    end
    merchants
  end
  def average_item_price_for_merchant(merchant_id)
    items = sales_engine.find_all_by_merchant_id(merchant_id)
    price_total = 0
    items.each do |item|
     price_total += item.unit_price
   end
    average_stuff(price_total , items.count)
  end
  def average_average_price_per_merchant
    averages = sales_engine.merchant_id_list.map do |merchant_id|
      average_item_price_for_merchant(merchant_id)
    end
    average_stuff(averages.sum, sales_engine.merchant_id_list.length)
  end
  def golden_items
    sales_engine.pass_item_array.find_all do |item|
      item.unit_price_to_dollars >= (sales_engine.average_item_price + (item_price_standard_deviation * 2))
    end
  end
end

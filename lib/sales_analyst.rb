require_relative 'sales_engine'
require 'bigdecimal'

class SalesAnalyst
  attr_reader :sales_engine
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def total_items
    sales_engine.item_count
  end

  def total_merchants
    sales_engine.merchant_count
  end

  def average_items_per_merchant
     ( total_items/ total_merchants).round(2)
  end

  def average_item_price
    sales_engine.average_item_price
  end

  def item_count_per_merchant
    sales_engine.item_count_per_merchant
  end

  def average_items_per_merchant_standard_deviation
    average_items = average_items_per_merchant
    sum = 0
    sales_engine.item_count_per_merchant.each do |merchant, count|
      sum += (average_items - count)**2
    end
    sum = (sum / total_merchants).round(2)
    (sum ** 0.5).round(2)
  end

  def average_item_price_standard_deviation
    average = average_item_price
    sum = sales_engine.all_items.sum do |item|
      (average - item.unit_price_to_dollars)**2
    end
    sum = (sum / total_items).round(2)
    (sum ** 0.5).round(2)
  end

  def merchants_with_high_item_count
    one_deviation = average_items_per_merchant_standard_deviation + average_items_per_merchant
    merchants = item_count_per_merchant.select do |id, count|

      sales_engine.find_merchant_id(id) if count > one_deviation
    end
    merchants     # = []
  end             # sales_engine.merchants.each do |merchant|


  def average_item_price_for_merchant(merchant_id)
    all_items = sales_engine.find_merchant_id(merchant_id)
    sum = all_items.sum do |item|
      item.unit_price
    end
    (sum / all_items.length).round(2)
  end

  def merchant_item_total
    item_count_per_merchant.sum do |id, count|
      count
    end
  end

  def average_average_price_per_merchant
    all_items = item_count_per_merchant.length
    all_averages = sales_engine.all_merchants.sum do |merchant|
      average_item_price_for_merchant(merchant.id)
      #require "pry"; binding.pry
    end

    (all_averages / all_items).round(2)
  end

  def golden_items
    two_deviation = (average_item_price_standard_deviation * 2) + average_item_price
    sales_engine.all_items.find_all do |item|
      item.unit_price_to_dollars > two_deviation
    end
  end
end

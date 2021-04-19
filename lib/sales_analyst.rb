require_relative 'sales_engine'
require 'bigdecimal'

class SalesAnalyst
  attr_reader :sales_engine
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def item_count
    sales_engine.item_count
  end

  def merchant_count
    sales_engine.merchant_count
  end

  def average_items_per_merchant
     ( item_count / merchant_count).round(2)
  end

  def average_price
    sales_engine.average_price
  end

  def item_count_per_merchant
    sales_engine.item_count_per_merchant
  end

  def average_items_per_merchant_standard_deviation
    average_items = average_items_per_merchant
    sum = sales_engine.item_count_per_merchant.sum do |merchant, count|
      (average_items - count)**2
    end
    sum = (sum / merchant_count).round(2)
    (sum ** 0.5).round(2)
  end

  def average_item_price_standard_deviation
    average = average_price
    sum = sales_engine.all_items.sum do |item|
      (average - item.unit_price_to_dollars)**2
    end
    sum = (sum / item_count).round(2)
    (sum ** 0.5).round(2)
  end

  # refactor to return merchant object
  def merchants_with_high_item_count
    one_deviation = average_items_per_merchant_standard_deviation + average_items_per_merchant
    high_merchants = []
    item_count_per_merchant.find_all do |id, count|
      high_merchants << sales_engine.find_by_id(id) if count > one_deviation
    end
    high_merchants
  end


  def average_item_price_for_merchant(merchant_id)
    all_items = sales_engine.find_all_by_merchant_id(merchant_id)
    sum = all_items.sum do |item|
      item.unit_price
    end
    (sum / all_items.length).round(2)
  end

  def average_average_price_per_merchant
    all_items = item_count_per_merchant.length
    all_averages = sales_engine.all_merchants.sum do |merchant|
      average_item_price_for_merchant(merchant.id)
    end

    (all_averages / all_items).round(2)
  end

  def golden_items
    two_deviation = (average_item_price_standard_deviation * 2) + average_price
    sales_engine.all_items.find_all do |item|
      item.unit_price_to_dollars > two_deviation
    end
  end

  def


end

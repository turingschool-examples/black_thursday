require 'csv'
require 'bigdecimal/util'
require_relative 'sales_engine'

class SalesAnalysis
  attr_reader :engine

  def initialize(sales_engine)
    @engine = sales_engine
  end

  def average_items_per_merchant
    (items.all.count.to_f / all_merchants.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    merchant_items = find_merchant_ids.map do |id|
      items_by_merchant_id(id).size.to_f
    end
    num = merchant_items.map do |item_count|
      (item_count - average_items_per_merchant) ** 2
    end.reduce(:+) / (all_merchants.size - 1)
    deviation = Math.sqrt(num).round(2)
  end

  def merchants_with_high_item_count
    standard = (average_items_per_merchant +
                average_items_per_merchant_standard_deviation)
    high_item_merchants = all_merchants.find_all do |merchant|
      merchant.items.count > standard
    end
    merchants_names = high_item_merchants.map {|merchant| merchant.name}
    merchants_names
  end

  def average_item_price_for_merchant(id)
    #find the merchant
    merchant = merchants.find_by_id(id)
    #find the items of the merchant
    items = merchant.items
    #find the prices of those items
    prices = items.map {|item| item.unit_price}
    #find the averages of those prices
    price = prices.reduce(:+)
    average_price = (price / prices.count).round(2)
  end

  private

  def items
    engine.items
  end

  def merchants
    engine.merchants
  end

  def all_merchants
    merchants.all
  end

  def items_by_merchant_id(id)
    items.find_all_by_merchant_id(id)
  end

  def find_merchant_ids
    all_merchants.map {|merch| merch.id}
  end

end

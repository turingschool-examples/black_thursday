require 'csv'
require 'bigdecimal/util'
require_relative 'sales_engine'

class SalesAnalysis
  attr_reader :engine

  def initialize(sales_engine)
    @engine = sales_engine
  end

  def average_items_per_merchant
    (item_repo.all.count.to_f / merchants.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    merchant_items = find_merchant_ids.map do |id|
      items_by_merchant_id(id).size.to_f
    end
    num = merchant_items.map do |item_count|
      (item_count - average_items_per_merchant) ** 2
    end.reduce(:+) / (merchants.size - 1)
    deviation = Math.sqrt(num).round(2)
  end

  def merchants_with_high_item_count
    standard = (average_items_per_merchant +
                average_items_per_merchant_standard_deviation)
    high_item_merchants = merchants.find_all do |merchant|
      merchant.items.count > standard
    end
    merchants_names = high_item_merchants.map {|merchant| merchant.name}
    merchants_names
  end

  def average_item_price_for_merchant(id)
    #find the merchant
    merchant = merchant_repo.find_by_id(id)
    #find the items of the merchant
    items = merchant.items
    #find the prices of those items
    prices = items.map {|item| item.unit_price}
    #find the averages of those prices
    price = prices.reduce(:+)
    average_price = (price / prices.count).round(2)
  end

  def average_average_price_per_merchant
    #find the merchant id for every merchant
    merchant_ids = find_merchant_ids
    #find the average price for every merchant
    average_prices = merchant_ids.map do |merch_id|
      average_item_price_for_merchant(merch_id)
    end.reduce(:+)
    #add those prices together
    #divide by total merchants
    (average_prices / merchants.size).round(2)
  end

  private

  def item_repo
    engine.items
  end

  def merchant_repo
    engine.merchants
  end

  def merchants
    merchant_repo.all
  end

  def items_by_merchant_id(id)
    item_repo.find_all_by_merchant_id(id)
  end

  def find_merchant_ids
    merchants.map {|merch| merch.id}
  end

end

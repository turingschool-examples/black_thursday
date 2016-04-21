require 'csv'
require 'bigdecimal/util'
require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :engine

  def initialize(sales_engine)
    @engine = sales_engine
  end

  def average_items_per_merchant
    (items.count.to_f / merchants.count.to_f).round(2)
  end

  def average_price_of_items
    prices = items.map {|item| item.unit_price}
    total_price = prices.reduce(:+)
    average_price = total_price / items.count
    average_price.round(2)
  end

  def average_items_per_merchant_standard_deviation
    merchant_items = find_merchant_ids.map do |id|
      items_by_merchant_id(id).size.to_f
    end
    standard_deviation(merchant_items)
  end

  def average_price_of_items_standard_deviation
    item_prices = items.map {|item| item.unit_price}
    standard_deviation(item_prices)
  end

  def merchants_with_high_item_count
    standard = (average_items_per_merchant +
                average_items_per_merchant_standard_deviation)
    merchants.find_all do |merchant|
      merchant.items.count > standard
    end
  end

  def golden_items
    golden_price = average_price_of_items_standard_deviation*2 +
                   average_price_of_items
    golden = items.find_all do |item|
      item.unit_price >= golden_price
    end
    golden
  end


  def average_item_price_for_merchant(id)
    merchant = merchant_repo.find_by_id(id)
    prices = merchant.items.map {|item| item.unit_price}
    average_price = (prices.reduce(:+) / prices.count).round(2)
    average_price
  end

  def average_average_price_per_merchant
    merchant_ids = find_merchant_ids
    average_prices = merchant_ids.map do |merch_id|
      average_item_price_for_merchant(merch_id)
    end.reduce(:+)
    (average_prices / merchants.size).round(2)
  end

  private

  def item_repo
    engine.items
  end

  def merchant_repo
    engine.merchants
  end

  def items
    item_repo.all
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

  def standard_deviation(array)
    mean = array.reduce(:+) / array.count
    second_array = array.map {|number| (number - mean) ** 2}
    product = second_array.reduce(:+) / (array.count - 1)
    deviation = Math.sqrt(product).round(2)
    deviation
  end

end

require_relative 'merchant'
require_relative 'sales_engine'
require_relative 'item_repository'
require_relative 'item'
require_relative 'csv_parser'
require_relative 'calculator'
require 'time'
require 'pry'

class SalesAnalyst

  include Calculator

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

#-----Navigation_Methods-----#

  def merchant_repository
    sales_engine.merchants
  end

  def all_merchants
    merchant_repository.all
  end

  def find_merchant_by_id(id)
    merchant_repository.find_by_id(id)
  end

  def find_merchant_items(id)
    find_merchant_by_id(id).items
  end

#-----/Navigation_Methods-----#

#-----Merchant_Analysis_Methods-----#

  def count_items_per_merchant
     all_merchants.map do |merchant|
      merchant.items.length.to_f
    end
  end

  def average_items_per_merchant
    average(count_items_per_merchant)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(count_items_per_merchant)
  end

  def merchants_with_high_item_count
    all_merchants.find_all do |merchant|
        merchant.items.length > one_standard_deviation_above_mean
      end
  end

  def merchant_item_prices(id)
    find_merchant_items(id).map do |item|
      item.unit_price
    end
  end

  def average_item_price_for_merchant(id)
    average(merchant_item_prices(id))
  end

  def average_merchant_prices
    all_merchants.map do |merchant|
      id = merchant.id
      average_item_price_for_merchant(id)
    end
  end

#-----/Merchant_Analysis_Methods-----#

 

end


require_relative 'sales_engine'
require_relative 'merchant'
require_relative 'calculator'
require 'bigdecimal'

class SalesAnalyst

  include Calculator

  attr_reader :sales_engine

  def initialize (sales_engine)
    @sales_engine = sales_engine
  end

# ------ Data Structure Navigation ------
  def merchant_repository
    sales_engine.merchants
  end

  def items_repository
    sales_engine.items
  end

# ----------- Search methods -----------

  def items_per_merchant
    merchant_repository.merchants.map { |merchant| merchant.items.length }
  end

  def price_of_items_per_merchant(merchant_id)
    item_array = items_repository.find_all_by_merchant_id(merchant_id)
    item_array.map { |item| item.unit_price }
  end

  def price_per_item
    items_repository.items.map { |item| item.unit_price }
  end

  def average_price_per_item
    average(price_per_item)
  end

#------ Merchant methods per spec ------

  def average_items_per_merchant
    average(items_per_merchant)
  end

  def average_items_per_merchant_standard_deviation
    std_dev(items_per_merchant)
  end

  def merchants_with_high_item_count
    std_dev = average_items_per_merchant_standard_deviation
    avg = average_items_per_merchant

    merchant_repository.merchants.select do |merchant|
      merchant.items.length > (avg + std_dev)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    average(price_of_items_per_merchant(merchant_id))
  end

  def average_average_price_per_merchant
    price_averages = merchant_repository.merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    average(price_averages)
  end

  def golden_items
    price_std_dev = std_dev(price_per_item)
    items_repository.items.select { |item| item.unit_price > (price_std_dev * 2) }
  end
end

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
    all_items = se.item_repo.all.length.to_f
    all_merchants = se.total_merchants.to_f
    (all_items/all_merchants).round(2)
  end

  def create_all_merchant_ids
    se.merchant_repo.all.map do |merchant|
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
    merchant = se.merchant_repo.find_by_id(merchant_id)
    @merchant_item_array << merchant.items
    merchant_item_array.length
  end

  def average_item_price_per_merchant(merchant_id)
    merchant = se.merchant_repo.find_by_id(merchant_id)
    num_items = items_per_merchant(merchant_id)
    #there is some CRAZY bug in here that's not allowing the id to 
    #function properly in the previous method. When I manually enter
    #the id in pry, it works and returns the correct amount, but
    #when I run the code, it comes up 1 or 2 fewer items than it should.
    #NO IDEA
    aggregate_price = se.item_repo.find_item_price_by_id(merchant_id)
    merchant_price_array = []
    merchant_price_array << aggregate_price
    merchant_price_array.reduce(:+)
    (aggregate_price/num_items).round(2)
  end
end

  ###create a method for the previous array thing###
    
  # def average_price_per_item_for_all_merchants
  #   total_merchants = se.total_merchants.to_f
  #   sum_averages = total_merchants.reduce(0) do |sum, merchant|
  #     sum + average_item_price_for_merchant(merchant.id)
  #   end
  #   (sum_averages/total_merchants).round(2)
  # end

  # def golden_items
  #   standard_deviation
  #   price_threshold = 
  #   se.item_repo.all.find_all do |item|
  #     item.unit_price_to_dollars >= price_threshold
  #   end
  # end

 
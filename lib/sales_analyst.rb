require 'csv'
require 'pry'
require './lib/sales_engine'

class SalesAnalyst
  # include Calculations
  attr_reader :parent

  def initialize(sales_engine)
    @parent = sales_engine
  end

  def average_items_per_merchant
      all_items = parent.item_repo.all.length.to_f
      all_merchants = parent.merchant_repo.all.length.to_f
      (all_items/all_merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    #will live in outside module
    #set = [x..x+n]
    #set mean
    #standard_deviation = sqrt(((x-mean)**2 + .. + (x+n - mean)** 2))/set.length-1)
  end

  def average_item_price_per_merchant(merchant_id)
   desired_id = merchant_id
    merchant = parent.item_repo.find_by_id(desired_id)
    binding.pry
    aggregate_price = merchant.items.reduce(0) do |sum, item|
      sum + item.unit_price
      sum
    end
    (aggregate_price/merchant.num_items).round(2)
  end

  def golden_items
    #find items 2 or more standard_deviation above average price
    #return these in an array
  end
end
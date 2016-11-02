require 'csv'
require 'pry'
require './lib/sales_engine'

class SalesAnalyst
  def initialize(data, sales_engine)
    @parent = sales_engine
  end

  def average_items_per_merchant
    #for each merchant.items/number of merchants

  end

  def average_items_per_merchant_standard_deviation
    #set = [x..x+n]
    #set mean
    #standard_deviation = sqrt(((x-mean)**2 + .. + (x+n - mean)** 2))/set.length-1)
  end

  def average_item_price_per_merchant
    #for all merchants.item find price total
    # add all merchant prices
    #divide by number of merchants
  end

  def golden_items
    #find items 2 or more standard_deviation above average price
    #return these in an array
  end
end
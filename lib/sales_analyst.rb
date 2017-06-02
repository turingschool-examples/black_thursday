require 'pry'
require './lib/sales_engine'
require 'bigdecimal'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    var = collected_merchant_array
    average = (var.reduce(0) { |sum, num| sum += num})/var.length.to_f
    average.round(2)
  end

  def collected_merchant_array
      all_merchants = []
      merchant_array = @sales_engine.merchants.all
      merchant_array.each do |merchant|
        item = merchant.items
        average_array << item.length
      end
      all_merchants
  end

  

end

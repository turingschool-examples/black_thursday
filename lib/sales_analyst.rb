require 'pry'
require './lib/sales_engine'

class SalesAnalyst
  attr_reader :sales_engine
  
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    var = collected_merchant_array
    average = (var.reduce(0) { |sum, num| sum += num})/var.length.to_f
    average.round(2)
    average
  end

  def collected_merchant_array
    array_1 = []
    merch_array = @sales_engine.merchants.merchants
    merch_array.each do |merchant|
      it = merchant.items
      array_1 << it.length
    end
    array_1
  end




end

require 'pry'
require_relative 'sales_engine'
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
        all_merchants << item.length
      end
      all_merchants
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation
  end

  def standard_deviation
    array_1 = collected_merchant_array
    average = average_items_per_merchant
    array_2 = array_1.map{|num| (num-average)**2}
    final = Math.sqrt((array_2.reduce(:+))/(array_2.length-1))
    final.round(2)
  end

  def merchants_with_high_item_count
    mr = sales_engine.merchants.all
    var = average_items_per_merchant + average_items_per_merchant_standard_deviation
    mr.find_all do |merchant|
      merchant.items.length >= var
    end
  end




end

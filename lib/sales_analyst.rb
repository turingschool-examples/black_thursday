require 'pry'
require_relative 'sales_engine'
require 'bigdecimal'

class SalesAnalyst
 attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    merchant = sales_engine.merchants.all
    items = sales_engine.items.all

    average = (items.length.to_f)/(merchant.length)
    average.round(2)
  end

  def collected_items_hash
    all_merchants = {}
    mr = @sales_engine.merchants.all
    mr.each do |merchant|
      item = sales_engine.collected_items(merchant.id)
      all_merchants[merchant.id] = item.length
    end
    all_merchants
  end

  def standard_deviation(values)
    average = values.reduce(:+)/values.length.to_f
    average_average = values.reduce(0) {|val, num| val += ((num - average)**2) }
    Math.sqrt(average_average / (values.length-1)).round(2)
    # require "pry"; binding.pry
  end

  def average_items_per_merchant_standard_deviation
    value = collected_items_hash.values
    standard_deviation(value)
    # require "pry"; binding.pry
  end

  def merchants_with_high_item_count
    mr = sales_engine.merchants.all
    v = average_items_per_merchant+average_items_per_merchant_standard_deviation
    mr.find_all do |merchant|
      # require "pry"; binding.pry
      merchant.items.length >= v
    end
  end


end

require_relative 'sales_engine'
require_relative 'standard_deviation'
require 'pry'

class SalesAnalyst
  include StandardDeviation
  attr_reader   :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def total_items
    sales_engine.items.items.count
  end

  def total_merchants
    sales_engine.merchants.merchants.count
  end

  def average_items_per_merchant
    (total_items.to_f / total_merchants.to_f).round(2)
  end

  def collect_items_per_merchant
    sales_engine.merchants.merchants.map do |merchant|
      merchant.items.length
    end
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(collect_items_per_merchant).round(2)
  end

end

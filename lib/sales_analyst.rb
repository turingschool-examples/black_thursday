require './lib/sales_engine'
require './lib/merchant_repository'
require './lib/item_repository'
require 'pry'

class SalesAnalyst
  attr_reader :sales_engine,
              :merchant

  include Math

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @merchant = merchant
  end

  def total_items_per_merchant(merchant_id)
    sales_engine.merchants.find_by_id(merchant_id).items.count
  end

  def total_merchants
    sales_engine.merchants.all
  end

  def total_items
    sales_engine.items.all
  end

  def average_items_per_merchant
    (total_items.length / total_merchants.length.to_f)
  end

  def set
    total_merchants.map do |merchant|
      total_items_per_merchant(merchant.id)
    end
  end
#refactor into two methods: sum squares and keep average_items_per_merchant_standard_deviation
  def sum_squares
    set.reduce(0) do |sum_squares, items|
    sum_squares += ((items - average_items_per_merchant).abs.to_f)**2
    sum_squares
    end
  end

  def average_items_per_merchant_standard_deviation
    std_dev = sqrt( (sum_squares / (total_merchants.length - 1))).round(2)
  end



end

# require './lib/sales_engine'
require_relative 'sales_engine'

class SalesAnalyst

  attr_reader :se

  def initialize(se)
    @se = se
  end
  
  def average_items_per_merchant
    average = se.total_items / se.total_merchants.to_f
    average.round(2)
  end

  def average_items_per_merchant_standard_deviation    
    se.standard_deviation_for_merchant_items.round(2)
  end

  def merchants_with_high_item_count
    require 'pry'; binding.pry
    
    se.merchants_with_high_item_count

  end

  def merchants_with_high_item_count
  end

  def average_item_price_for_merchant(id)
    se.average_item_price_for_merchant(id).round(2)
  end

  def average_average_price_per_merchant
    se.average_average_price_per_merchant.round(2)
  end

  def golden_items
    se.golden_items
  end
end

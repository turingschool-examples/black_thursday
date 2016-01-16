require_relative 'sales_engine'
require          'pry'

class SalesAnalyst
  attr_reader :se

  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    @se.merchants.all.count #=> Gives me the total amount of merchants
    
    #array of merchants
    #somehow iterate through the damn
    # arr.inject(0.0) { |sum, el| sum + el } / arr.size
    #
  end

  def average_items_per_merchant_standard_deviation

  end

  def merchants_with_low_item_count

  end

  def average_item_price_for_merchant

  end

  def average_price_per_merchant

  end

  def golden_items

  end
end

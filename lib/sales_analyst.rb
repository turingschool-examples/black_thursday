require "bigdecimal"
require "pry"
class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def merchant_items_count(merchant_id)
    @sales_engine.find_items_by_merchant_id(merchant_id).count
  end

  def merchant_count
    @sales_engine.merchant_count
  end

  def item_count
    @sales_engine.item_count
  end

  def average_items_per_merchant
  (item_count/merchant_count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    total = all_merchants.map do |merchant|
      ((merchant_items_count(merchant.id)) - average_items_per_merchant)**2
    end
    Math.sqrt(total.reduce(:+)/(total.length-1)).round(2)
  end

  def all_merchants
    @sales_engine.all_merchants
  end

  def merchants_with_high_item_count
    all_merchants.find_all do |merchant|
      merchant_items_count(merchant.id) > (average_items_per_merchant_standard_deviation*2)
    end
  end





  #-average_item_price_for_merchant
  #add the unit prices of the items and divide them by the total number of items
  #SHOULD RETURN BIGDECIMAL

  #average AVERAGE price per merchant

  # golden_items top 2.5%    correct?
end

#methods:

  #sa.average_items_per_merchant_standard_deviation # => 3.26

  #sa.merchants_with_high_item_count # => [merchant, merchant, merchant]

  #sa.average_item_price_for_merchant(6) # => BigDecimal

  #sa.average_average_price_per_merchant # => BigDecimal

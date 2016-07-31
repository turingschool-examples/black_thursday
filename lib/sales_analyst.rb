require "bigdecimal"
require "pry"
class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def merchant_items(merchant_id)
    @sales_engine.find_items_by_merchant_id(merchant_id)
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

  def all_items
    @sales_engine.all_items
  end

  def merchants_with_high_item_count
    standard_deviation = average_items_per_merchant_standard_deviation
    all_merchants.find_all do |merchant|
      merchant_items_count(merchant.id) > (standard_deviation*2)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    total = merchant_items(merchant_id).map do |item|
      item.unit_price
    end
    (total.reduce(:+)/total.length).round(2)
  end

  def average_average_price_per_merchant
    averages = all_merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
  (averages.reduce(:+)/all_merchants.length).round(2)
  end

  def average_item_price
    total = all_items.map do |item|
      item.unit_price
    end
    (total.reduce(:+)/total.length).round(2)
  end

  def standard_deviation_of_items
    total = all_items.map do |item|
      ((item.unit_price) - average_item_price)**2
    end
    Math.sqrt(total.reduce(:+)/(total.length-1))
  end

  def golden_items
    standard_deviation = standard_deviation_of_items
    all_items.find_all do |item|
      item.unit_price > (standard_deviation*3)
    end
  end

end



  #-average_item_price_for_merchant
  #add the unit prices of the items and divide them by the total number of items
  #SHOULD RETURN BIGDECIMAL

  #average AVERAGE price per merchant

  # golden_items top 2.5%    correct?

#methods:

  #sa.average_items_per_merchant_standard_deviation # => 3.26

  #sa.merchants_with_high_item_count # => [merchant, merchant, merchant]

  #sa.average_item_price_for_merchant(6) # => BigDecimal

  #sa.average_average_price_per_merchant # => BigDecimal

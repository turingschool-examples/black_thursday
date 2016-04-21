require_relative 'sales_engine'
require 'pry'
require 'bigdecimal'

class SalesAnalyst
  def initialize(sales_engine)
    @sales_engine = sales_engine
    @mr = @sales_engine.merchants
  end

def average_items_per_merchant
  merchant_array = @mr.merchant_array
  items_per_merchant = merchant_array.map do |merch|
    item_array = merch.items
    item_array.length
  end
  array_length = BigDecimal(items_per_merchant.length)
  total = BigDecimal(items_per_merchant.reduce(:+))
  average = sprintf("%.02f",(total/ array_length)).to_f
end

def average_items_per_merchant_standard_deviation
  sum = 0
  merchant_array = @mr.merchant_array
  items_per_merchant = merchant_array.map do |merch|
    item_array = merch.items
    item_array.length
  end

  items_per_merchant.each do |element|
    num = (BigDecimal(element) - average_items_per_merchant) ** BigDecimal(2.0)
    sum += num
  end
  num_of_elements = @items_per_merchant.length
  std_dev = sqrt(sum/num_of_elements)
end

def merchants_with_high_item_count
end

def average_item_price_for_merchant(merchant_id)
  merchant = @mr.find_by_id(merchant_id)
  array_of_items = merchant.items
  item_prices = array_of_items.map do |item|
    item.unit_price
  end
  num_of_items = BigDecimal(item_prices.length)
  total = BigDecimal(item_prices.reduce(:+))
  average = BigDecimal(sprintf("%.02f",(total/ num_of_items)))
end

def average_average_price_per_merchant
  merchant_array = @mr.merchant_array
  average_item_price_array = merchant_array.map do |merch|
    average_item_price_for_merchant(merch.id)
  end
  total = BigDecimal(average_item_price_array.reduce(:+))
  num_of_items = BigDecimal(average_item_price_array.length)
  average = BigDecimal(sprintf("%.02f", (total/num_of_items)))
end

def golden_items
end

end

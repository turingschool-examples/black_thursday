require_relative 'sales_engine'
require_relative 'merchant'
require 'bigdecimal'

class SalesAnalyst

  attr_reader :sales_engine

  def initialize (sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
      i = sales_engine.items.items.length.to_f 
      m = sales_engine.merchants.merchants.length.to_f
      BigDecimal.new(i/m, 3).to_f
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    item_array = sales_engine.merchants.merchants.map { |merchant| merchant.items.length }
    array_sum = item_array.reduce(0) { |sum, item_count| sum + (item_count - average)**2 }
    BigDecimal.new(Math.sqrt(array_sum/(item_array.length - 1)), 3).to_f
  end

  def merchants_with_high_item_count
    sd = average_items_per_merchant_standard_deviation
    array = sales_engine.merchants.merchants.select { |merchant| merchant.items.length > (sd + average_items_per_merchant) }
  end

  def average_item_price_for_merchant(merchant_id)
    item_array = sales_engine.items.find_all_by_merchant_id(merchant_id)
    item_sum = item_array.inject(0) { |sum, item| sum + item.unit_price.to_f }
    BigDecimal.new(item_sum / item_array.length, 4)
  end

  def average_average_price_per_merchant
    merchant_total = sales_engine.merchants.merchants.inject(0) { |sum, merchant| sum + average_item_price_for_merchant(merchant.id).to_f }
    BigDecimal.new(merchant_total / sales_engine.merchants.merchants.length, 6).floor(2)
  end

  def golden_items
    item_total = sales_engine.items.items.inject(0) { |sum, item| sum + item.unit_price}
    item_avg = item_total / sales_engine.items.items.length
    price_array = sales_engine.items.items.map { |item| item.unit_price}
    std_dev = price_array.reduce(0) { |sum, price| sum + ((price - item_avg)**2) }
    final_dev = Math.sqrt(std_dev / (price_array.length - 1))
    sales_engine.items.items.select { |item| item.unit_price > ((final_dev*2) + item_avg)}    
  end

end
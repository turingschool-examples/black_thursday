require 'bigdecimal'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    (sales_engine.items.all.length.to_f/sales_engine.merchants.all.length).round(2)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(item_count_by_merchant)
  end


  def merchants_with_high_item_count
    high_count = average_items_per_merchant + standard_deviation(item_count_by_merchant)
    sales_engine.merchants.all.find_all do |merchant|
      merchant.items.length >= high_count
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = sales_engine.merchants.find_by_id(merchant_id)
    total_price = merchant.items.reduce(0) do |sum, item|
      sum + item.unit_price
    end
    (total_price/BigDecimal.new(merchant.items.length)).round(2)
  end

  def average_average_price_per_merchant
    total = sales_engine.merchants.all.reduce(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id)
    end
    (total/BigDecimal.new(sales_engine.merchants.all.length)).round(2)
  end

  def golden_items
    high_price = item_price_average + (2 * item_price_standard_deviation)
    sales_engine.items.all.find_all do |item|
      item.unit_price_to_dollars >= high_price
    end
  end


  def item_price_array
    sales_engine.items.all.map do |item|
      item.unit_price_to_dollars
    end.sort
  end

  def item_price_average
    average(item_price_array).round(2)
  end

  def item_price_standard_deviation
    standard_deviation(item_price_array)
  end


  def item_count_by_merchant
    sales_engine.merchants.all.map do |merchant|
      merchant.items.length
    end.sort
  end

  def item_count_standard_deviation
    standard_deviation(item_count_by_merchant)
  end

  def sum(array)
    array.reduce(0) { |sum, item| sum + item }
  end

  def average(array)
    sum(array)/array.length.to_f
  end

  def standard_deviation(array)
    average = average(array)
    sum_squares = array.reduce(0) do |sum, item|
      sum + (item - average)**2
    end
    result = sum_squares/(array.length - 1).to_f
    Math.sqrt(result).round(2)
  end

end

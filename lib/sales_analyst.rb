require_relative 'sales_engine'
require 'pry'
require 'bigdecimal'

class SalesAnalyst
  def initialize(sales_engine)
    sales_engine = sales_engine
    @mr = sales_engine.merchants
    @items_per_merchant = []
    @merchant_array = @mr.merchant_array
    @ir = sales_engine.items.item_repository

  end

  def find_items_per_merchant_array
    @items_per_merchant = @merchant_array.map do |merch|
      item_array = merch.items
      item_array.length
    end
  end

  def average_items_per_merchant
    items_array = find_items_per_merchant_array
    calculate_the_average(items_array).to_f
  end

  def calculate_the_average(array)
    array_length = BigDecimal(array.length)
    total = BigDecimal(array.reduce(:+))
    BigDecimal(sprintf("%.02f",(total/array_length)))
  end

  def average_items_per_merchant_standard_deviation
    items_per_merchant_array = find_items_per_merchant_array
    average = calculate_the_average(items_per_merchant_array)
    calculate_std_deviation(items_per_merchant_array, average)
  end

  def calculate_std_deviation(array, array_avg)
    std_dev_a = array.map {|num| (num.to_f - array_avg)**2}
    std_dev = Math.sqrt((std_dev_a.reduce(:+))/((std_dev_a.length)-1))
    sprintf("%.02f", std_dev).to_f
  end

  def merchants_with_high_item_count
    item_count = average_items_per_merchant + average_items_per_merchant_standard_deviation
    merchants_highest_count_items(item_count)
  end

  def merchants_highest_count_items(item_count)
    @merchant_array.find_all do |merchant|
      merchant.items.count > item_count
    end
  end

  def average_item_price_for_merchant(merchant_id)
    array_of_items = @mr.find_by_id(merchant_id).items
    item_prices = array_of_items.map do |item|
      item.unit_price
    end
    calculate_the_average(item_prices)
  end

  def average_average_price_per_merchant
    avg_price = @merchant_array.map do |merch|
      average_item_price_for_merchant(merch.id)
    end
    calculate_the_average(avg_price)
  end

  def golden_items
    golden_price = find_golden_item_price
    @ir.find_all do |item|
      item.unit_price > golden_price
    end
  end

  def find_price_array
    price_array = @ir.map {|item| item.unit_price}
  end

  def find_golden_item_price
    average = calculate_the_average(find_price_array)
    std_dev = calculate_std_deviation(find_price_array, average)
    golden_price = average + ( 2 * std_dev)
  end
end

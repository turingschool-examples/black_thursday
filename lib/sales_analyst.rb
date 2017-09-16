require_relative "sales_engine"
require 'pry'
require_relative './merchant_math'

class SalesAnalyst

  include MerchantMath

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def merchants_and_items
    make_merchants_and_things(sales_engine.items)
  end

  def average_items_per_merchant
    merchants_and_items
    average_things_per_merchant(merchants_and_items)
  end

  def average_items_per_merchant_standard_deviation
    merchants_and_items
    average_things_per_merchant_standard_deviation(merchants_and_items)
  end

  def std_dev
    average_items_per_merchant_standard_deviation
  end

  def merchants_with_high_item_count
    merchant_ids = []
    one_above  = average_items_per_merchant + std_dev
    merchants_and_items.each do |key,value|
      merchant_ids << key.to_i if  value > one_above
    end
    merchants = []
    merchant_ids.each do |id|
      merchants << sales_engine.merchants.find_by_id(id)
    end
    merchants
  end

  def average_item_price_for_merchant_unrounded(merchant_id)
    total_items = sales_engine.items.find_all_by_merchant_id(merchant_id)
    item_prices = total_items.map do |item|
                    item.unit_price
                  end
    total_item_prices = item_prices.sum
    return 0.00 if total_items.length == 0
    total_item_prices / total_items.length
  end

  def average_item_price_for_merchant(merchant_id)
    average_item_price_for_merchant_unrounded(merchant_id).round(2)
  end

  def average_average_price_per_merchant
    average_price_array = sales_engine.merchants.all.map do |merchant|
                            average_item_price_for_merchant_unrounded(merchant.id)
                          end
    sum_averages = average_price_array.sum
    (sum_averages / sales_engine.merchants.all.count).floor(2)
  end

  def average_item_price
    all_item_prices_sum = 0
    sales_engine.items.all.each do |item|
       all_item_prices_sum += item.unit_price_float
    end
    all_item_prices_sum / sales_engine.items.all.count
  end

  def square_each_item_average_difference
    calculation_item_array_sum = 0
    sales_engine.items.all.each do |item|
      calculation_item_array_sum += ((item.unit_price_float) - (average_item_price)) ** 2
    end
    calculation_item_array_sum
  end

  def standard_deviation_for_item_cost
    final = Math.sqrt(square_each_item_average_difference / (sales_engine.merchants.all.count - 1))
    final.round(3)
  end

  def avg_item_price_plus_2x_std_dev
   (average_item_price + standard_deviation_for_item_cost * 2)
  end

  def golden_items
    golden_items_list = []
    sales_engine.items.all.each do |item|
      if (item.unit_price_float)  >= avg_item_price_plus_2x_std_dev
        golden_items_list << item
        puts "Yowza"
      end
    end
      golden_items_list
  end



end

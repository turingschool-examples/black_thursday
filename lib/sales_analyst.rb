require_relative "sales_engine"
require 'pry'


class SalesAnalyst

  attr_reader :se

  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    item_counts = hash_of_merchants_and_number_of_items
    total_items = item_counts.values.sum
    total_merchants = item_counts.length
    (total_items/total_merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    #item_counts = hash_of_merchants_and_number_of_items
    # item_counts: {merchant_id => #items, ...}
    individual_minus_average = []
    individual_minus_average << hash_of_merchants_and_number_of_items.values.map do |number_of_items|
                                  number_of_items - average
                                end
    individual_minus_average_squared = individual_minus_average.flatten.map {|num| num ** 2}
    std_dev_top = individual_minus_average_squared.sum
    number_of_elements = hash_of_merchants_and_number_of_items.values.count
    Math.sqrt(std_dev_top / (number_of_elements - 1)).round(2)
  end

  def hash_of_merchants_and_number_of_items
    item_array = se.items.all
    merchant_ids = item_array.map do |item|
                     item.merchant_id
                   end
   item_counts = Hash.new 0
   merchant_ids.each do |merchant_id|
     item_counts[merchant_id] += 1.0
   end
   return item_counts
  end

  def std_dev
    average_items_per_merchant_standard_deviation
  end


  def merchants_with_high_item_count
    merchant_ids = []

    item_counts = hash_of_merchants_and_number_of_items
    one_above  = average_items_per_merchant + std_dev
    item_counts.each do |key,value|
      merchant_ids << key.to_i if  value > one_above
    end
    merchants = []
    merchant_ids.each do |id|
      merchants << se.merchants.find_by_id(id)
    end
    merchants
  end

  def average_item_price_for_merchant(merchant_id)
    total_items = se.items.find_all_by_merchant_id(merchant_id)
    item_prices = total_items.map do |item|
                    item.unit_price
                  end
    total_item_prices = item_prices.sum
    return 0.00 if total_items.length == 0
    (total_item_prices / total_items.length).round(2)
  end

  # sum all of the averages and find the average price across all merchants
  # sa.average_average_price_per_merchant # => BigDecimal

  def average_average_price_per_merchant
  end
##### Golden Items calc's




  def average_item_price
    all_item_prices =  []
    se.items.all.each do |item|
       all_item_prices << item.unit_price.to_f * 100
    end
    all_item_prices.sum / se.items.all.count
  end

  def square_each_item_average_difference
    calculation_item_array = []
    se.items.all.each do |item|
      # binding.pry
      calculation_item_array << ((item.unit_price.to_f * 100) - (average_item_price)) ** 2
    end
    calculation_item_array.sum
  end

  def standard_deviation_for_item_cost
    final = Math.sqrt(square_each_item_average_difference / (se.items.all.count - 1))
    final.round(3)
  end

  def avg_item_price_plus_2x_std_dev
    (average_item_price + standard_deviation_for_item_cost * 2)
  end

  def golden_items

    golden_items_list = []
    se.items.all.each do |item|
      if (item.unit_price * 100)  >= avg_item_price_plus_2x_std_dev
        golden_items_list << item.name
        puts "Yowza"
      end
    end
      golden_items_list
  end



end

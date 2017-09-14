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
    average_price_array = se.items.all.map do |item|
                          average_item_price_for_merchant(item.merchant_id.to_f)
                        end
    sum_averages = average_price_array.sum
    (sum_averages / average_price_array.count).round(2)
  end


end

require_relative "sales_engine"
require "math"

class SalesAnalyst

  attr_reader :se

  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    item_counts = hash_of_merchants_and_number_of_items
    total_items = item_counts.values.sum
    total_merchants = item_counts.length
    total_items/total_merchants
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    item_counts = hash_of_merchants_and_number_of_items
    # item_counts: {merchant_id => #items, ...}
    individual_minus_average = item_counts.values.map do |number_of_items|
                                 number_of_items - average
                               end
    individual_minus_average_squared = individual_minus_average.map {|num| num ** 2}
    std_dev_top = individual_minus_average_squared.sum
    sqrt(std_dev_top / 2)
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
   item_counts
  end

  # standard dev
  # Take the difference between each number and the mean and square it
  # Sum these square differences together
  # Divide the sum by the number of elements minus 1
  # Take the square root of this result
  # Or, in pseudocode:
  #
  # set = [3,4,5]
  #
  # std_dev = sqrt( ( individual_minus_average_squared+(4-4)^2+(5-4)^2 ) / 2 )

end

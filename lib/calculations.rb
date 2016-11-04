require 'bigdecimal'

module Calculations
  array = [3,4,5]#####
  sum_result = array.reduce(:+)
  puts sum_result

  mean_result = BigDecimal.new(sum_result / array.length)
  puts mean_result

  square_result = array.inject(0){|sum,item| sum += item**2 }
  variance = BigDecimal.new(square_result)/BigDecimal.new(array.length)
  puts variance

  upper_result = array.inject(0){|sum, item| sum += (item - mean_result)**2 }
  before_square_result = BigDecimal.new(upper_result) / BigDecimal.new(array.length - 1)
  std_dev = Math.sqrt(before_square_result)
  puts std_dev
end



# #Calculations need to solve this:
#
# Do most of our merchants offer just a few items or do they represent a warehouse?
# #sa.average_items_per_merchant # => 2.88
#
# And what's the standard deviation?
# #sa.average_items_per_merchant_standard_deviation # => 3.26
#
# Which merchants are more than one standard deviation above the average number of products offered?
# sa.merchants_with_high_item_count # => [merchant, merchant, merchant]
#
# Are these merchants selling commodity or luxury goods? Let's find the average price of a merchant's items (by supplying the merchant ID):
# sa.average_item_price_for_merchant(6) # => BigDecimal
#
# Then we can sum all of the averages and find the average price across all merchants (this implies that each merchant's average has equal weight in the calculation):
# sa.average_average_price_per_merchant # => BigDecimal
#
# Which are our "Golden Items", those two standard-deviations above the average item price? Return the item objects of these "Golden Items".
# sa.golden_items # => [<item>, <item>, <item>, <item>]
cd

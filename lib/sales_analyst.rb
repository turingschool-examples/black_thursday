require './lib/sales_engine'
require './lib/merchant_repository'
require './lib/item_repository'
require './lib/item'
require './lib/merchant'
require 'csv'
require 'pry'

class SalesAnalyst
  attr_reader :analyst_items,
              :analyst_merchants

#How to access data insie this class:
    # => @analyst_items.all.count
    # => or
    # => @analyst_merchants.all.upcase
    # => get it? use "all" after the @analyst_whatever to get to the good stuff,
    # => then call the method after the all. Love you all, good night.

  def initialize(data)
    @analyst_items = data[:items]
    @analyst_merchants = data[:merchants]
  end

  def average_items_per_merchant
    (@analyst_items.all.count.to_f / @analyst_merchants.all.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    items_per_merchant_array = []
    item_count = 0
    @analyst_merchants.all.each do |merchant|
      item_count = 0
      @analyst_items.all.each do |item|
        if item.merchant_id == merchant.id
          item_count += 1
        end
      end
      items_per_merchant_array << item_count
    end
    sum = 0
    items_per_merchant_array.each do |ipm|
      sum += (ipm - average_items_per_merchant)**2
    end
    Math.sqrt(sum / items_per_merchant_array.count).round(2)
  end

  def merchants_with_high_item_count
    #Which merchants are more than one standard deviation
    #above the average number of products offered?
    #should return and array of merchant objects
  end

  def average_item_price_for_merchant(merchant_id)

    #some math or something idk
    #use BigDecimal here
  end

  def average_average_price_per_merchant
    #i don't even know anymore
    #Then we can sum all of the averages and find the average price across all
    # merchants (this implies that each merchant’s average has equal weight in the calculation)
    #use Big Decimal again
  end

  def golden_items
    #i'm going to take a break
    #"Which are our “Golden Items”, those two standard-deviations above
    #the average item price?" Returns an ARRAY of ITEM OBJECTS
  end
end


# items_per_merchant_array = []
# set = []
#   @analyst_merchants.all.each  do |merchant|
#     merchants_items = []
#     @analyst_items.all.each  do |item|
#       if item.merchant_id == merchant.id
#         merchants_items << item
#       end
#     end
#   items_per_merchant_array << merchants_items.count

require_relative 'sales_engine'
require 'bigdecimal'
require 'pry'

class SalesAnalyst

  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    number_of_merchants = @se.merchants.all.count
    number_of_items = @se.items.all.count
    (number_of_items.to_f/number_of_merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    number_of_merchants = @se.merchants.all.count
    count_of_each_merchant_item =
    @se.merchants.all.map do |merchant|
      merchant.items.count
    end
    difference_between_mean_and_count_squared =
    count_of_each_merchant_item.map do |num|
      (average_items_per_merchant - num)**2
    end
    summed_differences = difference_between_mean_and_count_squared.reduce(:+)
    amount_less_one = count_of_each_merchant_item.count - 1
    Math.sqrt(summed_differences.to_f/amount_less_one).round(2)
  end

  def merchants_with_high_item_count
    high_sellers = []
    average = average_items_per_merchant
    standard_deviation = average_items_per_merchant_standard_deviation
    @se.merchants.all.each do |merchant|
      if merchant.items.count > (average + (1*standard_deviation))
        high_sellers << merchant
      end
    end
    high_sellers
  end

  def average_item_price_for_merchant(merchant_id)
    total_item_count = @se.merchants.find_by_id(merchant_id).items.count
    price_array = []
    @se.merchants.find_by_id(merchant_id).items.each do |item|
      price_array << item.price
    end
      total_price = price_array.reduce(:+)
      average_price = total_price / total_item_count
      BigDecimal.new(average_price / 100).round(2)
  end

  def average_average_price_per_merchant
    array = []
    @se.merchants.all.each do |merchant|
      # binding.pry
      array << self.average_item_price_for_merchant(merchant.id)
    end
    BigDecimal.new(array.reduce(:+) / array.count).round(2)
  end

end

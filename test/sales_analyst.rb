require_relative './merchant_repository'
require_relative './item_repository'
require 'pry'

class SalesAnalyst
  def initialize(sales_engine)
    @se = sales_engine
  end

  def average_items_per_merchant
    (@se.items.all.count.to_f/@se.merchants.all.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    hash = item_count_per_merchant_id
    differences_squared = square_differences(hash.values,
                                             average_items_per_merchant)
    sum = sum(differences_squared)
    sum_div = sum/hash.count
    Math.sqrt(sum_div).round(2)
  end

  def merchants_with_high_item_count
    hash = item_count_per_merchant_id
    merchant_ids = merchant_ids_with_high_item_count(hash)
    merchants_from_ids(merchant_ids)
  end

  def average_item_price_for_merchant(id)
    prices = find_prices_for_merchant(id)
    sum = sum(prices)
    (sum/prices.count).round(2)
  end

  def average_average_price_per_merchant
    sum = @se.merchants.all.inject(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id)
    end
    (sum/@se.merchants.all.count).round(2)
  end

  def golden_items
    prices = find_prices
    average = sum(prices)/prices.count
    differences_squared = square_differences(prices, average)
    sum = sum(differences_squared)
    sum_div = sum/prices.count
    std_dev = Math.sqrt(sum_div).round(2)
    threshold = average + std_dev * 2
    find_golden_items(@se.items.all, threshold)
  end

 # -------- Helper Methods ---------

 def item_count_per_merchant_id
   hash = Hash.new(0)
   @se.items.all.each do |item|
     hash[item.merchant_id] += 1
   end
   hash
 end

 def square_differences(values,average)
   values.map do |value|
     (value-average)**2
   end
 end

 def sum(numbers)
   numbers.inject(0) do |sum, num|
     sum + num
   end
 end

 def merchant_ids_with_high_item_count(hash)
   threshold = average_items_per_merchant +
               average_items_per_merchant_standard_deviation
   hash.find_all do |key, value|
     value > threshold
   end
 end

 def merchants_from_ids(ids)
   ids.map do |id, value|
     @se.merchants.find_by_id(id)
   end
 end

 def find_prices_for_merchant(id)
   prices = []
   @se.items.all.each do |item|
     prices << item.unit_price if item.merchant_id == id
   end
   prices
 end

 def average(numbers)
   sum(numbers)/numbers.count
 end

 def find_prices
   @se.items.all.inject([]) do |array, item|
     array << item.unit_price
   end
 end

 def find_golden_items(items, threshold)
   items.find_all do |item|
     item.unit_price > threshold
   end
 end
end

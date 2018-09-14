require 'pry'
require 'date'

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

 def average_invoices_per_merchant
   (@se.invoices.all.count.to_f/@se.merchants.all.count).round(2)
 end

  def average_invoices_per_merchant_standard_deviation
    hash = invoice_count_per_merchant_id
    differences_squared = square_differences(hash.values,
                                         average_invoices_per_merchant)
                                         sum = sum(differences_squared)
                                         sum_div = sum/hash.count
    Math.sqrt(sum_div).round(2)
  end

  def top_merchants_by_invoice_count
    above_sd = two_above_standard_deviation
    invoice_count_per_merchant_id.map do |id, count|
      @se.merchants.find_by_id(id) if count >= above_sd
    end.compact
  end

  def bottom_merchants_by_invoice_count
    invoice_count_per_merchant_id.map do |id, count|
      @se.merchants.find_by_id(id) if count <= two_below_standard_deviation
    end.compact
  end

  def top_days_by_invoice_count
    highest_day = []
    above_sd = two_above_sd_for_day
    number_of_invoices_per_day.map do |day, count|
    highest_day << day if count > above_sd
    end
    highest_day.compact
  end

  def invoice_status(status)
    decimal = invoices_grouped_by_status[status]
    (decimal.to_f / @se.invoices.all.count * 100).round(2)
  end

#helpers
  def invoice_count_per_merchant_id
    hash = Hash.new(0)
      @se.invoices.all.each do |invoice|
      hash[invoice.merchant_id] += 1
      end
     hash
  end

  def two_above_standard_deviation
    (average_invoices_per_merchant_standard_deviation * 2) + average_invoices_per_merchant
  end

  def two_below_standard_deviation
    average_invoices_per_merchant -
    (average_invoices_per_merchant_standard_deviation * 2)
  end

  def invoices_grouped_by_status
    group_status = @se.invoices.all.group_by do |invoice|
      invoice.status
    end
    group_status.each do |status, invoices|
      group_status[status] = invoices.count
    end
  end

  def two_above_sd_for_day
    (calculate_sd_by_day * 1) + average_invoices_per_day
  end

  def calculate_sd_by_day
    array = number_of_invoices_per_day.values
    average = average_invoices_per_day
    sd = standard_deviation(array, average)
  end

  def group_invoices_by_days_of_the_week
    @se.invoices.all.group_by do |invoice|
      invoice.created_at.strftime('%A')
    end
  end

  def number_of_invoices_per_day
    invoice_by_day = Hash.new(0)
    group_invoices_by_days_of_the_week.each do |day, invoices|
      invoice_by_day[day] = invoices.count
    end
    invoice_by_day
  end

  def average_invoices_per_day
    (@se.invoices.all.count.to_f/group_invoices_by_days_of_the_week.count).round(2)
  end

  def differences_by_day(key)
    difference = group_invoices_by_days_of_the_week[key].count - average_invoices_per_day
    difference.round(2)
  end

  def  differences_by_day_squared(key)
    squared = differences_by_day(key) ** 2
    squared.round(2)
  end

  def standard_deviation(array, average)
    count_minus_one = (array.count - 1)
    sum = array.reduce(0.0) do |total, amount|
      total + (amount - average) ** 2
    end
    ((sum / count_minus_one) ** (1.0 / 2)).round(2)
  end
end

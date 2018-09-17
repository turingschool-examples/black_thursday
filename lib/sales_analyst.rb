require 'bigdecimal'
require_relative '../lib/sales_engine'
require_relative '../lib/black_thursday_helper'
require_relative '../lib/sales_analyst_deviation_helper'
require 'pry'

class SalesAnalyst
  include BlackThursdayHelper
  include SalesAnalystHelper

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    total_merchants = @sales_engine.merchants.all.count
    total_items = @sales_engine.items.all.count
    BigDecimal((total_merchants.to_f/total_items),3)
  end

  def average_items_per_merchant_standard_deviation
    mean = mean_method
    items_per_merchant = all_merchants.map do |merchant|
      @sales_engine.items.find_all_by_merchant_id(merchant.id).size
    end
    standard_dev(items_per_merchant, mean)
  end

  def merchants_with_high_item_count
    goal = average_items_per_merchant + average_items_per_merchant_standard_deviation

    all_merchants.find_all do |merchant|
      @sales_engine.items.find_all_by_merchant_id(merchant.id).size > goal
    end
  end

  def average_item_price_per_merchant(merchant_id)
    items = @sales_engine.items.find_all_by_merchant_id(merchant_id)
    item_sum = items.inject(0) do |sum, item|
      sum + item.unit_price
    end
    average_price = item_sum/(items.count)
    BigDecimal(average_price, 4).round(2)
  end

  def average_average_price_per_merchant
    merchant_item_averages = all_merchants.map do |merchant|
      average_item_price_per_merchant(merchant.id)
    end
    averages_summed = merchant_item_averages.inject(0) do |sum, average|
      sum + average
    end
    averages_total = (averages_summed/ merchant_item_averages.size).round(2)
    BigDecimal(averages_total, 4)
  end

  def average_invoices_per_merchant
    total_merchants = @sales_engine.merchants.all.count
    total_invoices = @sales_engine.invoices.all.count
    BigDecimal((total_merchants.to_f/total_invoices),3)
  end

def average_invoices_per_merchant_standard_deviation
  mean = mean_method_for_invoices
  invoices_per_merchant = all_merchants.map do |merchant|
    @sales_engine.invoices.find_all_by_merchant_id(merchant.id).size
  end
  standard_dev(invoices_per_merchant, mean)
end

def top_merchants_by_invoice_count
  mean = mean_method_for_invoices
  doubled_standard_deviation = average_invoices_per_merchant_standard_deviation * 2
  all_invoices.find_all do |invoice|
  # binding.pry
    #ok so this goes into the invoices and find all the ones for particular merchant
    #then it will count it. if thats more than the standard deviation for the other merchants,
    #its "golden"-aka that one merchant has way more invoices to their name
    @sales_engine.invoices.find_all_by_merchant_id(invoice.merchant_id).size > (doubled_standard_deviation + mean)
  end
end

def bottom_merchants_by_invoice_count
    mean = mean_method_for_invoices
    doubled_standard_deviation = average_invoices_per_merchant_standard_deviation * 2
    all_invoices.find_all do |invoice|
      @sales_engine.invoices.find_all_by_merchant_id(invoice.merchant_id).size < (doubled_standard_deviation - mean)
    end
end
#
# def top_days_by_invoice_count
#     times = @sales_engine.invoices.all.map do |invoice|
#     invoice.created_at
#   end
#   times.map do |time|
#     time.
# end

def invoice_status(status)
  #so we need to calculate the percentage of invoices with each status present
  #get the total of each invoice with each status
  total_invoices = @sales_engine.invoices.all.count

  words = @sales_engine.invoices.all.map do |invoice|
    invoice.status
  end
  hash = Hash.new 0
  words.each do |word|
    hash[word] += 1
  end
  hash
  new_hash = Hash.new 0
  hash.each do |key, value|
     new_hash[key]= value.to_f/total_invoices * 100
  end
  new_hash
  #get the total of ALL invoices
  #divide the statuses invoices by the total of all the totals
  #multiply that by 100

end




end

# frozen_string_literal: true

require_relative './analyst_helper/helper'
# analyses various aspects of sales engine
# allows for analysis of different sales engine respoitories
class SalesAnalyst
  include AnalystHelper

  attr_reader :all_items_per_merchant,
              :all_invoices_per_merchant

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @all_items_per_merchant = @sales_engine.all_items_per_merchant
    @all_invoices_per_merchant = @sales_engine.all_invoices_per_merchant
    @all_invoices_per_day = @sales_engine.all_invoices_per_day
  end

  # def number_of_items_per_merchant
  #   @all_items_per_merchant.values.map(&:count)
  # end

  # def number_of_invoices_per_day
  #   @all_invoices_per_day.values.map(&:count)
  # end

  # def number_of_invoices_per_merchant
  #   @all_invoices_per_merchant.values.map(&:count)
  # end

  # def average_items_per_merchant
  #   item_count = @all_items_per_merchant.values.map(&:count)
  #   item_sum = find_sum(item_count)
  #   (item_sum.to_f / @all_items_per_merchant.values.count).round(2)
  # end

  # def average_invoices_per_merchant
  #   invoice_count = @all_invoices_per_merchant.values.map(&:count)
  #   find_mean(invoice_count).round(2)
  # end

  def find_sum(numbers)
    numbers.inject(0) { |sum, number| sum + number }
  end

  def find_mean(numbers)
    sum = find_sum(numbers)
    sum / numbers.count.to_f
  end

  def standard_deviation(numbers)
    mean = find_mean(numbers)
    diff_from_mean = numbers.map do |number|
      mean - number
    end
    squared = diff_from_mean.map do |number|
      number**2
    end
    sum = find_sum(squared)
    sum_over_count = (sum / (numbers.count - 1))
    Math.sqrt(sum_over_count)
  end

  # def average_items_per_merchant_standard_deviation
  #   standard_deviation(number_of_items_per_merchant).round(2)
  # end

  # def average_invoices_per_merchant_standard_deviation
  #   standard_deviation(number_of_invoices_per_merchant).round(2)
  # end


  def std_dev_above_mean(data_point, mean, standard_deviation)
    std_dev = standard_deviation
    diff_from_mean = data_point - mean
    (diff_from_mean / std_dev).round(2)
  end

  # def merchants_with_high_item_count
  #   std_dev = average_items_per_merchant_standard_deviation
  #   item_num_mean = find_mean(number_of_items_per_merchant)
  #   high_item_count_merchants = []
  #   @all_items_per_merchant.each_pair do |merchant,items|
  #     if std_dev_above_mean(items.count, item_num_mean, std_dev) >= 1
  #       high_item_count_merchants << @sales_engine.merchants.find_by_id(merchant)
  #     end
  #   end
  #   high_item_count_merchants
  # end

  # def top_merchants_by_invoice_count
  #   std_dev = average_invoices_per_merchant_standard_deviation
  #   invoice_num_mean = find_mean(number_of_invoices_per_merchant)
  #   high_invoice_count_merchants = []
  #   @all_invoices_per_merchant.each_pair do |merchant, invoices|
  #     if std_dev_above_mean(invoices.count, invoice_num_mean, std_dev) >= 2
  #       high_invoice_count_merchants << @sales_engine.merchants.find_by_id(merchant)
  #     end
  #   end
  #   high_invoice_count_merchants
  # end

  # def bottom_merchants_by_invoice_count
  #   std_dev = average_invoices_per_merchant_standard_deviation
  #   invoice_num_mean = find_mean(number_of_invoices_per_merchant)
  #   low_invoice_count_merchants = []
  #   @all_invoices_per_merchant.each_pair do |merchant, invoices|
  #     if std_dev_above_mean(invoices.count, invoice_num_mean, std_dev) <= -2
  #       merchants = @sales_engine.merchants.find_by_id(merchant)
  #       low_invoice_count_merchants << merchants
  #     end
  #   end
  #   low_invoice_count_merchants
  # end

  # def average_item_price_for_merchant(merchant_id)
  #   item_prices = @all_items_per_merchant[merchant_id].map(&:unit_price)
  #   BigDecimal((find_sum(item_prices)/item_prices.count)).round(2)
  # end

  def merchant_price_averages
    merchant_price_averages = []
    @all_items_per_merchant.each_key do |merchant_id|
      merchant_price_averages << average_item_price_for_merchant(merchant_id)
    end
    merchant_price_averages
  end

  def average_average_price_per_merchant
    merchant_price_averages
    find_mean(merchant_price_averages).round(2)
  end

  # def golden_items
  #   std_dev = standard_deviation(@sales_engine.all_item_prices_per_item.values)
  #   mean = find_mean(@sales_engine.all_item_prices_per_item.values)
  #   high_price_items = []
  #   @sales_engine.all_item_prices_per_item.each_pair do |item, price|
  #     if std_dev_above_mean(price, mean, std_dev) >= 2
  #       high_price_items << item
  #     end
  #   end
  #   high_price_items
  # end

  # def top_days_by_invoice_count
  #   std_dev = standard_deviation(number_of_invoices_per_day)
  #   mean = find_mean(number_of_invoices_per_day)
  #   high_traffic_days = []
  #   @all_invoices_per_day.each_pair do |day, invoices|
  #     if std_dev_above_mean(invoices.count, mean, std_dev) >= 1
  #       high_traffic_days << day
  #     end
  #   end
  #   high_traffic_days
  # end

  # def percent_of_total_invoices_per_status
  #   all_invoices = @all_invoices_per_day.values.flatten
  #   total = all_invoices.count
  #   grouped_by_status = all_invoices.group_by(&:status)
  #   grouped_by_status.each do |status,invoices|
  #     percent = (invoices.count / total.to_f) * 100
  #     grouped_by_status[status] = percent.round(2)
  #   end
  #   grouped_by_status
  # end

  # def invoice_status(status)
  #   percent_of_total_invoices_per_status[status]
  # end

end

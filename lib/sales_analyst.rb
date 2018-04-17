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

  def std_dev_above_mean(data_point, mean, standard_deviation)
    std_dev = standard_deviation
    diff_from_mean = data_point - mean
    (diff_from_mean / std_dev).round(2)
  end

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

end

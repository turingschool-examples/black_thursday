require_relative 'sales_engine'
require_relative 'standard_deviation'
require_relative 'analyst_helper'
require 'bigdecimal'
require 'pry'

class SalesAnalyst
  include StandardDeviation
  include AnalystHelper
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine    
  end

  def average_items_per_merchant
    format decimal average(item_counts).to_s
  end

  def average_invoices_per_merchant
    format decimal average(invoice_counts).to_s
  end

  def average_item_price_for_merchant(id)
    price_average_operator(id)
  end

  def average_average_price_per_merchant
    average_average_operator
  end

  def invoice_status(status)
    format decimal status_average_operator(status)
  end

  def average_items_per_merchant_standard_deviation
    format decimal standard_deviation(item_counts).to_s
  end

  def average_invoices_per_merchant_standard_deviation
    format decimal standard_deviation(invoice_counts).to_s
  end

  def merchants_with_high_item_count
    sales_engine.merchants.all.find_all do |merchant|
      merchant.items.count >= item_number_plus_one_deviation
    end
  end

  def top_days_by_invoice_count
    days_of_the_week.each_pair.map do |day, count|
      day if count > one_standard_deviation_above_mean_for_weekdays
    end.compact
  end

  def top_merchants_by_invoice_count
    merchant_list = sales_engine.merchants.all.find_all do |merchant|
      merchant.invoices.size >= one_standard_deviation_above_invoice_average
    end
  merchant_list.flatten
  end

  def bottom_merchants_by_invoice_count
    sales_engine.merchants.all.find_all do |merchant|
      merchant.invoices.size <= one_standard_deviation_below_invoice_average
    end
  end

  def golden_items
    all_golden_items_for_merchants
  end

end

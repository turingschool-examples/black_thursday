require_relative 'sales_engine'
require_relative 'standard_deviation'
require_relative 'analyst_helper'
require_relative 'analyst_operations'
require 'bigdecimal'
require 'pry'

class SalesAnalyst
  include StandardDeviation
  include AnalystHelper
  include AnalystOperations
  
  attr_reader :sales_engine,
              :merchants,
              :invoices,
              :items

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @merchants    = sales_engine.merchants.all
    @invoices     = sales_engine.invoices.all
    @items        = sales_engine.items.all
  end

  def average_items_per_merchant
    format decimal average_item_counts.to_s
  end

  def average_invoices_per_merchant
    format decimal average(invoice_counts).to_s
  end

  def average_item_price_for_merchant(id)
    format decimal price_average_operator(id).to_s
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
    merchants.find_all do |merchant|
      merchant.invoices.size <= one_standard_deviation_below_invoice_average
    end
  end

  def golden_items
    sales_engine.items.all.find_all do |item|
      item.unit_price >= two_standard_deviations_away_in_price
    end
  end

end

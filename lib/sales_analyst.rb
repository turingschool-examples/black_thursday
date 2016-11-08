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
    @sales_engine   = sales_engine
    @merchants      = sales_engine.merchants.all
    @invoices       = sales_engine.invoices.all
    @items          = sales_engine.items.all
    @item_prices    = items.map { |item| item.unit_price }
    @item_counts    = merchants.map { |merchant| merchant.items.size }
    @invoice_counts = merchants.map { |merchant| merchant.invoices.size }
  end

  def average_items_per_merchant
    format decimal average(@item_counts).to_s
  end

  def average_invoices_per_merchant
    format decimal average(@invoice_counts).to_s
  end

  def average_item_price_for_merchant(id)
    decimal(price_average_operator(id)).round(2)
  end

  def average_average_price_per_merchant
    average_average_operator
  end

  def invoice_status(status)
    format decimal status_average_operator(status)
  end

  def average_items_per_merchant_standard_deviation
    format decimal standard_deviation(@item_counts).to_s
  end

  def average_invoices_per_merchant_standard_deviation
    format decimal standard_deviation(@invoice_counts).to_s
  end

  def merchants_with_high_item_count
    one_deviation_above = item_number_plus_one_deviation
    @merchants.find_all do |merchant|
      merchant.items.count >= one_deviation_above
    end
  end

  def top_days_by_invoice_count
    one_deviation_above = one_standard_deviation_above_mean_for_weekdays
    days_of_the_week.each_pair.map do |day, invoice_count|
      day if invoice_count > one_deviation_above
    end.compact
  end

  def top_merchants_by_invoice_count
    one_deviation_above = one_standard_deviation_above_invoice_average
    merchant_list = @merchants.find_all do |merchant|
      merchant.invoices.size >= one_deviation_above
    end
  merchant_list.flatten
  end

  def bottom_merchants_by_invoice_count
    one_deviation_below = one_standard_deviation_below_invoice_average
    merchants.find_all do |merchant|
      merchant.invoices.size <= one_deviation_below
    end
  end

  def golden_items
    two_deviations = two_standard_deviations_away_in_price
    items.find_all do |item|
      item.unit_price >= two_deviations
    end
  end

end

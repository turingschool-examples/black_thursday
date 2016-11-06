require_relative 'sales_engine'
require_relative 'standard_deviation'
require 'bigdecimal'
require 'pry'

class SalesAnalyst
  include StandardDeviation
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine    
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(item_counts)
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(invoice_counts)
  end

  def top_merchants_by_invoice_count
    invoice_counts.find_all do |invoice_count|
      invoice_count > average_invoices_per_merchant + standard_deviation(invoice_counts) * 2
    end
  end

  def merchants_with_high_item_count
  end
  
  def average_items_per_merchant
    average(item_counts)
  end

  def average_invoices_per_merchant
    average(invoice_counts)
  end

  def invoice_counts
    sales_engine.merchants.all.map { |merchant| merchant.invoices.size }
  end

  def item_counts
    sales_engine.merchants.all.map { |merchant| merchant.items.size }
  end

  def average_item_price_for_merchant(id)
    all_prices = sales_engine.merchants.find_all_items_by_merchant(id).map do |item|
      item.unit_price
    end
    average(all_prices).round(2)
  end

  def average_average_price_per_merchant
    averages = sales_engine.merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    average(averages).round(2)
  end

  def average(collection)
    collection.reduce(&:+) / collection.size
  end

  
  #   # names = sales_engine.merchants.all.map { |merchant| merchant.name }
  #   # @item_counts.sort!.reverse!
  #   # @item_counts.zip(names)[0..2]
  # end

  # def golden_items
  # end
  
end

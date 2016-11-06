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
    BigDecimal.new(standard_deviation(item_counts).to_s).round(2).to_f
  end

  def average_invoices_per_merchant_standard_deviation
    BigDecimal.new(standard_deviation(invoice_counts).to_s).round(2).to_f
  end

  def top_merchants_by_invoice_count
    invoice_counts.find_all do |invoice_count|
      invoice_count > average_invoices_per_merchant + standard_deviation(invoice_counts) * 2
    end
  end

  def merchants_with_high_item_count
    item_counts.find_all do |item_count|
    item_count > average_items_per_merchant + standard_deviation(item_counts)
    end
  end
  
  def average_items_per_merchant
    BigDecimal.new(average(item_counts).to_s).round(2).to_f
  end

  def average_invoices_per_merchant
    BigDecimal.new(average(invoice_counts).to_s).round(2).to_f
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
    collection.reduce(&:+).to_f / collection.size.to_f
  end

  
  #   # names = sales_engine.merchants.all.map { |merchant| merchant.name }
  #   # @item_counts.sort!.reverse!
  #   # @item_counts.zip(names)[0..2]
  # end

  # def golden_items
  # end
  
end

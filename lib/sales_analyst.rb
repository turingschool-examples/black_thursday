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
  
  def average_items_per_merchant
    BigDecimal.new(average(item_counts).to_s).round(2).to_f
  end

  def average_invoices_per_merchant
    BigDecimal.new(average(invoice_counts).to_s).round(2).to_f
  end

  def average_item_price_for_merchant(id)
    BigDecimal.new(average(price_counts(id)).to_s).round(2)
  end

  def average_average_price_per_merchant
    averages = sales_engine.merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    BigDecimal.new(average(averages).to_s).round(2)
  end

  def invoice_status(status)
    matches = sales_engine.invoices.all.find_all do |invoice| 
      invoice.id if invoice.status.eql?(status)
    end
    BigDecimal.new(status_average_operator(matches)).round(2).to_f
  end

  def status_average_operator(matches)
    ((matches.size.to_f / sales_engine.invoices.all.size.to_f) * 100).to_s
  end

  def average(collection)
    collection.reduce(&:+).to_f / collection.size.to_f
  end

  def invoice_counts
    sales_engine.merchants.all.map { |merchant| merchant.invoices.size }
  end

  def item_counts
    sales_engine.merchants.all.map { |merchant| merchant.items.size }
  end

  def price_counts(id)
    sales_engine.merchants.find_all_items_by_merchant(id).map do |item|
      item.unit_price
    end
  end

  # def golden_items
  # end
  
end

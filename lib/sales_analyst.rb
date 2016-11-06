require_relative 'sales_engine'
require_relative 'standard_deviation'
require_relative 'analysis_setup'
require 'bigdecimal'
require 'pry'

class SalesAnalyst
  include StandardDeviation
  include AnalysisSetup
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine    
  end

  def average_items_per_merchant
    format BigDecimal.new average(item_counts).to_s
  end

  def average_invoices_per_merchant
    format BigDecimal.new(average(invoice_counts).to_s).round(2)
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
    format BigDecimal.new status_average_operator(matches)
  end

  def average_items_per_merchant_standard_deviation
    format BigDecimal.new standard_deviation(item_counts).to_s
  end

  def average_invoices_per_merchant_standard_deviation
    format BigDecimal.new standard_deviation(invoice_counts).to_s
  end

end

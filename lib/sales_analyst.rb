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

end

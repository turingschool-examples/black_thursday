require 'date'
require_relative 'analyzer'
require_relative 'merchant_analytics'
require_relative 'item_analytics'
require_relative 'invoice_analytics'
require_relative 'customer_analytics'



# Sales Analyst class for analyzing data
class SalesAnalyst < Analyzer
  include MerchantAnalytics
  include ItemAnalytics
  include InvoiceAnalytics
  include CustomerAnalytics

  attr_reader :engine
  def initialize(sales_engine)
    super(sales_engine)
  end

end

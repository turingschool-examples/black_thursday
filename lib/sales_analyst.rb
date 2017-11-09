require 'time'
require_relative 'merchant_analytics'
require_relative 'item_analytics'
require_relative 'business_intelligence'

class SalesAnalyst
  include MerchantAnalytics
  include ItemAnalytics
  include BusinessIntelligence

  attr_reader :sales_engine,
              :standard_deviation,
              :golden_items_dev,
              :ave_inv_per_merch

  def initialize(sales_engine)
    @sales_engine           = sales_engine
    @standard_dev           = average_items_per_merchant_standard_deviation
    @golden_items_dev       = golden_items_deviation
    @ave_inv_per_merch      = average_invoices_per_merchant
  end
end

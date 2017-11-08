require 'bigdecimal'
require_relative './sales_engine'
require_relative './invoice_analyst'
require_relative './item_analyst'
require_relative './customer_analyst'

class SalesAnalyst
  include InvoiceAnalyst
  include ItemAnalyst
  include CustomerAnalyst

  attr_reader :se,
              :invoice_count,
              :merchant_count,
              :item_count

  def initialize(sales_engine)
    @se = sales_engine
    @invoice_count = se.invoices.invoices.length
    @merchant_count = se.merchants.merchants.length
    @item_count = se.items.items.length
  end
end

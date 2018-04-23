require_relative "sales_engine"
require_relative "calculator"
require_relative "merchant_analyst"
require_relative "item_analyst"
require_relative "invoice_analyst"

class SalesAnalyst
  include Calculator
  include MerchantAnalyst
  include ItemAnalyst
  include InvoiceAnalyst

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def items
    @sales_engine.items
  end

  def merchants
    @sales_engine.merchants
  end

  def invoices
    @sales_engine.invoices
  end
end

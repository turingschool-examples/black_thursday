# SalesAnalyst
require_relative 'sales_engine'
class SalesAnalyst

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    sales_engine.items/sales_engine.merchant
  end
end

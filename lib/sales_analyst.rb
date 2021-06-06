require_relative './sales_engine'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    (@sales_engine.all_items.length.to_f / @sales_engine.all_merchants.length).round(2)
  end
end

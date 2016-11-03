require_relative 'sales_engine'

class SalesAnalyst
  attr_reader   :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def total_items
    sales_engine.items.count
  end

  def total_merchants
    sales_engine.merchants.count
  end

  def average_items_per_merchant
    total_items / total_merchants
  end

end

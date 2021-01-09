require 'pry'

class SalesAnalyst
  attr_reader :sales_engine
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    (total_items.to_f / total_merchants).round(2)
  end

  def total_items
    sales_engine.items.all.length
  end

  def total_merchants
    sales_engine.merchants.all.length
  end

end

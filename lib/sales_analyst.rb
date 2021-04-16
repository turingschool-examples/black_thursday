require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    @sales_engine.merchants.average_items_per_merchant
  end

  def average_items_per_merchant_standard_deviation
    @sales_engine.merchants.average_items_per_merchant_standard_deviation
  end

  def merchants_with_high_item_count
    @sales_engine.merchants.merchants_with_high_item_count
  end
end

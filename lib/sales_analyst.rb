require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    @sales_engine.path[:items]
  end
  # average_items_per_merchant
  # average_items_per_merchant_standard_deviation
  # merchants_with_high_item_coun
  # average_item_price_for_merchant(12334159)
  # golden_items
end

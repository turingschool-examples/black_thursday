require_relative './sales_engine'
require_relative './merchant_repo'
require_relative './item_repo'
require_relative './merchant'
require_relative './item'

class SalesAnalyst

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    @sales_engine.find_average
  end

  def average_items_per_merchant_standard_deviation
    @sales_engine.standard_deviation
  end

  def merchants_with_high_item_count
    @sales_engine.find_merchants_with_most_items
  end
end

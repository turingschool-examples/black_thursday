
class SalesAnalyst

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    (@sales_engine.items.all_item_data.count).to_f /
    (@sales_engine.merchants.all_merchant_data.count).to_f
  end

  def average_items_per_merchant_standard_deviation

  end
end

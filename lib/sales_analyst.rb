class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    (sales_engine.items.items.length.to_f/sales_engine.merchants.merchants.length).round(2)
  end


end

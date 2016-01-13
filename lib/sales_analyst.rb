class SalesAnalyst
attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def total_merchants
    sales_engine.merchants.all.count.to_f
  end

  def total_items
    sales_engine.items.all.count.to_f
  end

  def average_items_per_merchant
    total_items/total_merchants
  end

end

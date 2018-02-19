class SalesAnalyst
  attr_reader :sales_engine
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def items_per_merchant
    merchants = @sales_engine.merchants.all
    merchants.map do |merchant|
      merchant.items.count
    end
  end

  def average_items_per_merchant
    items_per_merchant.inject(0.0) do |sum, num|
      sum + num
    end / items_per_merchant.count
  end
end

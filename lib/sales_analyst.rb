class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    total_items = sales_engine.items.items.count
    total_merchants = sales_engine.merchants.merchants.count
    (total_items.to_f / total_merchants.to_f).round(2)
  end

  def counts_per_merchant(method)
    sales_engine.merchants.merchants.map do |merchant|
      method.call(merchant.id).count
    end
  end

  def mean
  end

  def average_items_per_merchant_standard_deviation
  end

end

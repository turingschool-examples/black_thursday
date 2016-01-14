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
    (total_items/total_merchants).round(2)
  end

  def variance_of_average_and_items
    merchants = sales_engine.merchants.all
    variances = []
    merchants.each do |merchant|
      variances <<
      (merchant.items.count - average_items_per_merchant) **2
    end
    variances.inject(:+)
  end

  def variance_divided_merchants
    variances = variance_of_average_and_items
    variances/(total_merchants - 1)
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(variance_divided_merchants).round(2)
  end

end

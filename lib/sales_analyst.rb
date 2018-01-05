class SalesAnalyst
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def merchants
    @sales_engine.merchants.all
  end

  def items_per_merchant
   merchants.map do |merchant|
     merchant.items.count
   end
  end

   def total_items
     items_per_merchant.sum
   end

  def average_items_per_merchant
    total_items.to_f / merchants.count.to_f
  end

  def sum_squared_differences_from_average
    items_per_merchant.map do |items|
      (items - average_items_per_merchant)**2
    end.sum
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(sum_squared_differences_from_average / (total_items - 1))
  end
end

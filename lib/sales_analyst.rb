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
    total_items / merchants.count
  end
end

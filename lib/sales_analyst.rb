require_relative './sales_engine'

class SalesAnalyst 
  attr_reader       :sales_engine, :item_repository, :merchant_repository
  def initialize(sales_engine)
    @sales_engine = sales_engine
    @item_repository = @sales_engine.items
    @merchant_repository = @sales_engine.merchants
  end
  
  def average_items_per_merchant 
     (@item_repository.items.count.to_f / @merchant_repository.all.count.to_f).round(2)
  end 
  
  
end 
require_relative './sales_engine'

class SalesAnalyst 
  attr_reader       :sales_engine, :item_repository, :merchant_repository
  def initialize(sales_engine)
    @sales_engine = sales_engine
    @item_repository = @sales_engine.items
    @merchant_repository = @sales_engine.merchants
  end
  
  # works
  def average_items_per_merchant 
     (@item_repository.items.count.to_f / @merchant_repository.all.count.to_f).round(2)
  end 
  
  #works, but may be an unnecessary step 
  def sort_items_by_merchant
    @item_repository.items.sort_by do |item|
      item.merchant_id 
    end  
  end 
  
  # below is not functional; using memo improperly
  def build_hash_of_merchant_item_counts
    items = @item_repository.items
    items.inject(Hash.new(0)) do |memo, user|
      memo[user.merchant_id] += 1
    end 
    return items 
  end 
  
  # def average_items_per_merchant_standard_deviation
  #   #need to find #items for each merchant 
  # end 
  
  # def differences_squared
  #   @merchant_repository.all.each do |element|
  #     element.items 
  # end 
  
  
  
end 
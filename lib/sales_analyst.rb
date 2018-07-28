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
     (@item_repository.all.count.to_f / @merchant_repository.all.count.to_f).round(2)
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
  
  # what if...
  # nested enumerables
  def merchant_id_item_counter
    m_item_count = Hash.new(0)
    sales_engine.merchants.all.map do |merchant|
      m_items = sales_engine.items.all.find_all do |item|
        item.merchant_id == merchant.id 
        # m_items   
      end
      m_item_count[merchant.id] += m_items.count
    end 
  end
  
  # def average_items_per_merchant_standard_deviation
  #   #need to find #items for each merchant 
  # end 
  
  # def differences_squared
  #   @merchant_repository.all.each do |element|
  #     element.items 
  # end 
  
  
  
end 
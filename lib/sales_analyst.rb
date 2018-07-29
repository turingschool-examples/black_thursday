require_relative './sales_engine'

class SalesAnalyst 
  attr_reader       :sales_engine, 
                    :item_repository, :merchant_repository, :merchant_id_item_counts
                    
  def initialize(sales_engine)
    @sales_engine = sales_engine
    @item_repository = @sales_engine.items
    @merchant_repository = @sales_engine.merchants
    @merchant_id_item_counts = nil
  end
  
  # works
  def average_items_per_merchant 
     (@item_repository.all.count.to_f / @merchant_repository.all.count.to_f).round(2)
  end
  
  # def average_items_per_merchant_standard_deviation
  #    
  # end 
  
  
  def sum_of_differences_squared
    merchant_id_item_counter
    avg = average_items_per_merchant
    counts = @merchant_id_item_counts
    sum = 0
    @merchant_repository.all.each do |merchant|
      sum += (counts[merchant.id] - avg)**2
    end  
    return sum 
  end
  
  def merchant_id_item_counter
    m_item_count = Hash.new(0)
    sales_engine.merchants.all.map do |merchant|
      m_items = sales_engine.items.all.find_all do |item|
        item.merchant_id == merchant.id 
        # m_items   
      end
      m_item_count[merchant.id] += m_items.count
    end 
    @merchant_id_item_counts = m_item_count 
  end
  
  
 
  
  
  
end 
require_relative './sales_engine'

class SalesAnalyst 
  attr_reader       :sales_engine, 
                    :item_repository, :merchant_repository, :merchant_id_item_counts,
                    :item_count_std_dev
                    
  def initialize(sales_engine)
    @sales_engine = sales_engine
    @item_repository = @sales_engine.items
    @merchant_repository = @sales_engine.merchants
    @merchant_id_item_counts = nil
    @item_count_std_dev = nil
  end
  
  def average_items_per_merchant_standard_deviation
    @item_count_std_dev =
    (Math.sqrt(sum_of_differences_squared / @merchant_repository.all.count)).round(2)
  end
  
  def sum_of_differences_squared
    merchant_id_item_counter
    avg = average_items_per_merchant
    counts = @merchant_id_item_counts
    sum = 0.00
    @merchant_repository.all.each do |merchant|
      sum += (counts[merchant.id].to_f - avg.to_f)**2
    end  
    return sum.round(2)
  end
  
  def average_items_per_merchant 
    (@item_repository.all.count.to_f / @merchant_repository.all.count.to_f).round(2)
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
  
  # sales_analyst.merchants_with_high_item_count # => [merchant, merchant, merchant] 
  
  def merchants_with_high_item_count
    ids_with_high_item_count.map do |id_array| 
      @merchant_repository.all.find do |merchant|
        merchant.id == id_array[0]
      end
    end
  end 
  
  def ids_with_high_item_count
    id_high_items = @merchant_id_item_counts.find_all do |id, count|
      count > @item_count_std_dev + average_items_per_merchant
    end
    # binding.pry 
    return id_high_items
  end  
end 
require_relative './sales_engine'

class SalesAnalyst
  attr_reader :sales_engine
  
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end
  
  def average_items_per_merchant
     total_number_of_items / total_number_of_merchants
  end
  
  def total_number_of_items
    sales_engine.item_repo.all.count
  end
  
  def total_number_of_merchants
    sales_engine.merchant_repo.all.count
  end
  
  def average_items_per_merchant_standard_deviation
    # sum = 0
    # divisor = total_number_of_merchants - 1
    # sales_engine.merchant_repo.all.each do |merchant|
    #   merchant_item_count = count_all_items_per_merchant(merchant)
    #   sum += ((merchant_item_count - average_items_per_merchant)**2)
    # end
    # std = Math.sqrt(sum / divisor)
    # std 
    sum_of_squares = sales_engine.merchant_repo.all.reduce(0) do |result, merchant|
      merchant_item_count = merchant.items.count
      result += ((merchant_item_count - average_items_per_merchant)**2)
    end
    Math.sqrt(sum_of_squares / (total_number_of_merchants - 1))
  end
  
  def merchants_with_high_item_count
    high_item_count = average_items_per_merchant + average_items_per_merchant_standard_deviation
    high_item_merchants = sales_engine.merchant_repo.all.find_all do |merchant|
      merchant.items.count > high_item_count
    end
  end
end
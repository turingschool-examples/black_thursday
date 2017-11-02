require_relative 'sales_engine'

class SalesAnalyst
              :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @merchant = @sales_engine.merchants.merchants
    @merchant_count = @merchant.count
  end

 def average_items_per_merchant
    item_count = @sales_engine.items.items.count
    item_count/@merchant_count.to_f
 end

 def average_items_per_merchant_standard_deviation
   squared_differences = @merchant.map do |merchant|
    (average_items_per_merchant - merchant.items.count)**2
    end
    sum = squared_differences.sum
    sum/(@merchant_count - 1)
  end

  def standard_deviation
   Math.sqrt(average_items_per_merchant_standard_deviation)
  end

  def merchants_having_high_item_count
    above_1_sigma = @merchant.find_all do |merchant|
       merchant.items.count > (average_items_per_merchant + standard_deviation)
     end
  end

  def average_item_price_fo_merchant(id)
    merchant = @sales_engine.merchants.find_by_id(id)
     sum = merchant.items.map {|item|item.unit_price}.sum
     average = sum/merchant.items.count if merchant.items.count > 0
  end

  def average_average_price_per_merchant
    average = @merchant.map do |merchant|
      average_item_price_fo_merchant(merchant.id)
    end.compact
    (average.sum/@merchant.count).truncate(3)
  end

 def golden_items
   items = @sales_engine.items.items
   items.find_all do |item|
     item.unit_price > (average_average_price_per_merchant + (standard_deviation*2))
   end
 end


end

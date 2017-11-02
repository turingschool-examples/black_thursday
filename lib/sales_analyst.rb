require_relative 'sales_engine'

class SalesAnalyst
              :parent

  def initialize(parent)
    @parent = parent
  end


 def average_items_per_merchant
    @merchant_count =  @parent.merchants.merchants.count
    item_count = @parent.items.items.count
     item_count/@merchant_count.to_f
 end

 def average_items_per_merchant_standard_deviation
   merchant = @parent.merchants.merchants
   squared_differences = merchant.map do |merchant|
    (average_items_per_merchant - merchant.items.count)**2
    end
    sum = squared_differences.sum
    sum/(@merchant_count - 1)
  end

  def standard_deviation
    return Math.sqrt(average_items_per_merchant_standard_deviation)
  end

  def merchants_having_high_item_count
    merchant = @parent.merchants.merchants
    # binding.pry
    above_1_sigma = merchant.find_all do |merchant|
       merchant.items.count > (average_items_per_merchant + standard_deviation)
     end
  end

# def mean
#       self.sum/self.length.to_f
#     end
#
#     def sample_variance
#       m = self.mean
#       sum = self.inject(0){|accum, i| accum +(i-m)**2 }
#       sum/(self.length - 1).to_f
#     end
#
#
#  end

 def merchants_with_high_item_count
 end

 def average_item_price_for_merchant(id)
 end

 def average_average_price_per_merchant

 end
end

require 'pry'

class SalesAnalyst
  attr_reader :se,
              :mr,
              :ir

  def initialize(se)
    @se = se
    @mr = @se.merchants
    @ir = @se.items
  end

  def average_items_per_merchant
    (@ir.all.count.to_f/@mr.all.count).round(2)
  end

  def count_items_per_merchant
     @ir.items.inject(Hash.new (0)) do |total, item|
       total[item.merchant_id]+= 1
       total
     end
  end

   def average_items_per_merchant_standard_deviation
     mean = average_items_per_merchant
       set = count_items_per_merchant.values.map do |item_count|
       ((item_count - mean) ** 2).round(2)
         end
         new_sum = set.inject(0) do |sum, number|
         sum + number
       end
       Math.sqrt(new_sum/@ir.all.count-1).round(2)
   end

   def merchant_with_high_item_count
     one_sd_above = average_items_per_merchant + average_items_per_merchant_standard_deviation
      count_items_per_merchant.map do |merchant_id, items_per_merchant|
      if items_per_merchant > one_sd_above
        merchant_id
      end
     end.compact
   end
end

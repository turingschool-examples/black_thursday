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

  def average_items_per_merchant_standard_deviation#(count_items_per_merchant)
     hash = count_items_per_merchant
      set = hash.values.map do |item_count|
      ((item_count - 0.77) ** 2).round(2)
        end
        new_sum = set.inject(0) do |sum, number|
        sum + number
      end
      Math.sqrt(new_sum/9).round(2)
  end
end

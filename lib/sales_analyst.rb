require 'bigdecimal/util'
require 'bigdecimal'

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
       total[item.merchant_id] += 1
       total
     end
  end

   def average_items_per_merchant_standard_deviation
     mean = average_items_per_merchant
     set = count_items_per_merchant.values.map do |item_count|
       ((item_count - mean) ** 2)
     end.sum

    Math.sqrt(set/(@mr.all.count-1)).round(2)
   end

  def merchants_with_high_item_count
    one_sd_above = average_items_per_merchant + average_items_per_merchant_standard_deviation
    count_items_per_merchant.map do |merchant_id, items_per_merchant|
      if items_per_merchant > one_sd_above
        @mr.find_by_id(merchant_id.to_i)
      end
    end.compact
  end

  def average_item_price_for_merchant(merchant_id)
    items = @ir.find_all_by_merchant_id(merchant_id)
      sum_unit_price = items.inject(0) do |sum,item|
       sum + item.unit_price
      end
    BigDecimal.new(sum_unit_price/items.count).round(2)
  end

  def items_by_merchant_id
    @ir.all.group_by do |item|
      item.merchant_id
    end
  end

  def average_average_price_per_merchant
    merchant_ids = items_by_merchant_id.keys
    average_average_price = merchant_ids.inject(0) do |sum, id|
      # binding.pry
      sum += average_item_price_for_merchant(id.to_i)
    end / merchant_ids.count
    average_average_price.round(2)
  end

  def average_items_price
    @ir.items.inject(0) do |sum,item|
      sum += item.unit_price
    end/@ir.all.count
  end

  def item_price_std_dev
    mean = average_items_price
    new_set = @ir.items.map do |item|
      (item.unit_price - mean)**2
    end.sum
     Math.sqrt(new_set/(@ir.all.count-1)).round(2)
  end


  def golden_items
    two_sd_above = (average_average_price_per_merchant + item_price_std_dev * 2)
    @ir.items.find_all do |item|
      item.unit_price > two_sd_above
    end
  end


end

require_relative 'sales_engine'
class SalesAnalyst
  attr_reader :engine
  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    (engine.items.all.length.to_f / engine.merchants.all.length).round(2)
  end

  def merch_hash
    hsh = engine.items.all.group_by do |item|
      item.merchant_id
    end
    hsh.map do |keys, values|
      hsh[keys] = values.count
    end
    hsh
  end

  # def std_dev(nums, avg)
  #   total = nums.sum do |num|
  #     (num - avg)**2
  #   end
  #   Math.sqrt(total / (nums.length - 1)).round(2)
  # end

  def average_items_per_merchant_standard_deviation
    sqr_diff = 0.0
    merch_hash.each do |merchant, items|
      sqr_diff += (items - average_items_per_merchant)**2
    end
    std_dev = Math.sqrt((sqr_diff / (merch_hash.keys.count - 1)))
    std_dev.round(2)
  end

  def merchants_with_high_item_count
    high_merchants = []
    merch_hash.each do |merchant, items|
     if items - average_items_per_merchant_standard_deviation > average_items_per_merchant
      high_merchants << merchant
     end
    end
    high_merchants.map do |merchant_id|
      engine.merchants.find_by_id(merchant_id)
    end
  end
end

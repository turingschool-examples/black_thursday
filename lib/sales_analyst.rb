require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    (@engine.items.all.length / @engine.merchants.all.length.to_f).round(2)
  end

  def items_per_merchant
    items_per_merchant_count = {}
    @engine.merchants.all.each do |merchant|
      count_num = @engine.items.all.count do |item|
        item.merchant_id == merchant.id
      end
      items_per_merchant_count[merchant] = count_num
    end
    items_per_merchant_count
  end

  def standard_dev(nums, average)
    total_sum = nums.sum {|nums| (nums - average) **2 }
    std_dev = Math.sqrt(total_sum / (nums.length - 1).to_f).round(2)
  end
end

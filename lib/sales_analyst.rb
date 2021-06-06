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

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    merchant_items = items_per_merchant.values
    standard_dev(merchant_items, average)
  end

  def merchants_with_high_item_count
    solution = []
    std_deviation_mean = (average_items_per_merchant * 1) + average_items_per_merchant_standard_deviation
    items_per_merchant.each do |merchant, number_of_items|
      solution << merchant if number_of_items >= std_deviation_mean
    end
    solution
  end
end

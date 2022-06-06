require_relative "../lib/sales_engine"

class SalesAnalyst
  attr_reader :items_path, :merchants_path
  def initialize(items_path, merchants_path)
    @items_path = items_path
    @merchants_path = merchants_path
  end

  def average_items_per_merchant
    # (@items_path.all.count.to_f / @merchants_path.all.count).round(2)
    mean = items_per_merchant.reduce(:+).to_f / items_per_merchant.count
    mean.round(2)
  end

  def all_items_by_merchant
    @items_path.all.group_by do |item|
      item.merchant_id
    end
  end

  def items_per_merchant
    all_items_by_merchant.map do |id, items|
      items.count
    end
  end

  def difference_squared
    items_per_merchant.map do |sum|
      (sum - average_items_per_merchant)**2
    end.sum
  end

  def average_items_per_merchant_standard_deviation
    variance = difference_squared / (items_per_merchant.count - 1)
    return standard_deviation = Math.sqrt(variance).round(2)
  end

  def merchants_with_high_item_count
    high_count = []
    goal = (average_items_per_merchant_standard_deviation + 1)
    all_items_by_merchant.select do |merchant, items|
        if items.count > goal
          high_count << @merchants_path.find_by_id(merchant)
        end
      end
      high_count
  end 

end

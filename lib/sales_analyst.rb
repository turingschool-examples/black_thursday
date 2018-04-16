require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    sum = items_per_merchant.reduce(:+)
    sum.to_f / items_per_merchant.count
  end

  def average_items_per_merchant_standard_deviation
    sum_of_differences = items_per_merchant.reduce(0) do |memo, item|
      memo += (item - average_items_per_merchant) ** 2
      memo
    end
    divided = sum_of_differences / (items_per_merchant.count - 1)
    Math.sqrt(divided).round(2)
  end

  def merchants_with_high_item_count
    mean = average_items_per_merchant
    std_dev = average_items_per_merchant_standard_deviation
    merchants.values.find_all do |merchant|
      merch_count = @sales_engine.items.find_all_by_merchant_id(merchant.id).count
      merch_count > (std_dev + mean)
    end
  end

  private

  def items
    @items ||= @sales_engine.items.contents
  end

  def merchants
    @merchants ||= @sales_engine.merchants.merchants
  end

  def items_per_merchant
    @items_per_merchant ||= items.values.group_by(&:merchant_id).values.map(&:count)
  end

  # average_item_price_for_merchant(12334159)
  # golden_items
end

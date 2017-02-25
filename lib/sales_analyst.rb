require 'pry'

class SalesAnalyst
  attr_reader :se, :avg_items_per_merchant, :avg_items_per_merchant_standard_deviation

  def initialize(sales_engine)
    @se = sales_engine
    @avg_items_per_merchant = average_items_per_merchant
    @avg_items_per_merchant_standard_deviation = average_items_per_merchant_standard_deviation
  end

  def average_items_per_merchant
    (se.items.all.count.to_f / se.merchants.all.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    avg = se.items.all.count.to_f / se.merchants.all.count.to_f

    squared_diffs = se.merchants.all.map do |merchant|
      (merchant.items.count - avg) ** 2
    end.reduce(:+)
    std_dev = Math.sqrt(squared_diffs / (se.merchants.all.count - 1)).round(2)
  end

  def merchants_with_high_item_count
    se.merchants.all.select do |merchant|
      merchant.items.count > avg_items_per_merchant + avg_items_per_merchant_standard_deviation
    end
  end

  def average_item_price_for_merchant(merchant_id)
    # find in our MR the merchant using find by ID
    # then reduce the item prices into an average

    merchant = se.merchants.find_by_id(merchant_id)
    total = merchant.items.reduce(0) do |sum, item|
      sum += item.unit_price
      sum
    end
    total / merchant.items.count
  end

end

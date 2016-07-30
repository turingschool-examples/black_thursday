require_relative '../lib/item_repository'


class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @all_merchants = @sales_engine.merchants.merchants
  end

  def average_items_per_merchant
    total_items = sales_engine.items.all.count
    total_merchants = sales_engine.merchants.all.count
    (total_items.to_f / total_merchants).round(2)
  end

  def items_per_merchant
    @all_merchants.keys.map do |merchant_id|
      sales_engine.items.find_all_by_merchant_id(merchant_id).count
    end
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    differences_squared = items_per_merchant.map do |number|
      (number - average) ** 2
    end
    Math.sqrt( differences_squared.reduce(:+) /
    (@all_merchants.count - 1).to_f ).round(2)
  end

  def above_one_standard_deviation
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def merchants_with_high_item_count
    aosd = above_one_standard_deviation
    @all_merchants.values.find_all do |merchant|
      sales_engine.items.find_all_by_merchant_id(merchant.id).count > aosd
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items = sales_engine.items.find_all_by_merchant_id(merchant_id)
    items.inject(0) do |sum, item|
      sum += item.unit_price / items.count.to_f
    end.round(2)
  end
end

# Let's find the average price of a merchant's items (by supplying the merchant ID):
# sa.average_item_price_for_merchant(6) # => BigDecimal


# sum all of the averages and find the average price across all merchants (this implies that each merchant's average has equal weight in the calculation):
# sa.average_average_price_per_merchant # => BigDecimal

require_relative '../lib/item_repository'


class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @all_merchants = @sales_engine.merchants.merchants
    @all_items = @sales_engine.items.items
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

  def sample_standard_deviation(sample, average)
    differences_squared = sample.map do |number|
      (number - average) ** 2
    end
    Math.sqrt( differences_squared.reduce(:+) /
    (sample.count - 1).to_f ).round(2)
  end

  def average_items_per_merchant_standard_deviation
    sample_standard_deviation(items_per_merchant, average_items_per_merchant)
  end

  def coefficient_of_variation(average, standard_deviation, coefficient)
    average + coefficient * standard_deviation
  end

  def merchants_with_high_item_count
    cov = coefficient_of_variation(average_items_per_merchant,
      average_items_per_merchant_standard_deviation, 1)
    @all_merchants.values.find_all do |merchant|
      sales_engine.items.find_all_by_merchant_id(merchant.id).count > cov
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items = sales_engine.items.find_all_by_merchant_id(merchant_id)
    items.inject(0) do |sum, item|
      sum += item.unit_price / items.count.to_f
    end.round(2)
  end

  def average_average_price_per_merchant
    total_merchants = @all_merchants.count
    @all_merchants.keys.inject(0) do |sum, merchant_id|
      sum += average_item_price_for_merchant(merchant_id) / total_merchants.to_f
    end.round(2)
  end

  def average_item_price
    total_items = @all_items.count
    @all_items.values.inject(0) do |sum, item|
      sum += item.unit_price / total_items.to_f
    end.round(2)
  end

  def item_price_standard_deviation
    item_prices = @all_items.values.map do |item|
      item.unit_price
    end
    sample_standard_deviation(item_prices, average_item_price)
  end

  def golden_items
    cov = coefficient_of_variation(average_item_price,
      item_price_standard_deviation, 2)
    @all_items.values.find_all do |item|
      item.unit_price > cov
    end
  end
end

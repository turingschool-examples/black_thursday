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

  def coefficient_of_variation(variation)
    average_items_per_merchant +
    variation * average_items_per_merchant_standard_deviation
  end

  def merchants_with_high_item_count
    cov = coefficient_of_variation(1)
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
    denominator = @all_merchants.count
    @all_merchants.keys.reduce(0) do |sum, merchant_id|
      sum += average_item_price_for_merchant(merchant_id) / denominator.to_f
    end.round(2)
  end

  def average_item_price
    denominator = sales_engine.items.items.count
    sales_engine.items.items.values.inject(0) do |sum, item|
      sum += item.unit_price / denominator.to_f
    end
  end

  def golden_items
    cov = average_item_price + sample_standard_deviation
    sales_engine.items.items.values.find_all do |item|
      item.unit_price >
    end
  end
end

require_relative './analysis_math'

class SalesAnalyst
  include AnalysisMath
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_item_price_for_merchant(id)
    merchant_items = @sales_engine.find_all_items_by_merchant_id(id)
    prices = get_item_prices(merchant_items)
    mean(prices).round(2)
  end

  def average_average_price_per_merchant
    all_merchants = @sales_engine.all_merchants
    total_average_price = all_merchants.reduce(0) do |result, merchant|
      result += average_item_price_for_merchant(merchant.id)
      result
    end
    average_price = (total_average_price / all_merchants.count).round(2)
  end

  def price_standard_deviation_for_merchant(id)
    merchant_items = @sales_engine.find_all_items_by_merchant_id(id)
    prices = get_item_prices(merchant_items)
    standard_deviation(prices)
  end

  def price_standard_deviation
    all_prices = get_item_prices(@sales_engine.all_items)
    standard_deviation(all_prices).round(2)
  end

  def golden_items(num_of_std = 2)
    @sales_engine.all_items.find_all do |item|
      item.unit_price > (average_average_price_per_merchant + num_of_std*price_standard_deviation)
    end
  end

  def average_items_per_merchant
    merchant_item_counts = get_merchant_item_counts(@sales_engine.all_merchants)
    mean(merchant_item_counts).round(2).to_f
  end

  def average_items_per_merchant_standard_deviation
    merchant_item_counts = get_merchant_item_counts(@sales_engine.all_merchants)
    standard_deviation(merchant_item_counts)
  end

  def merchants_with_high_item_count
    high_item_count = average_items_per_merchant + average_items_per_merchant_standard_deviation
    @sales_engine.all_merchants.find_all do |merchant|
      merchant.items.count > high_item_count
    end
  end

  def get_item_prices(items)
    items.map do |item|
      item.unit_price_to_dollars
    end
  end

  def get_merchant_item_counts(merchants)
    merchants.map do |merchant|
      merchant.items.count
    end
  end
end

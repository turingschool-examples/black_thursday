require_relative './analysis_math'

class SalesAnalyst
  include AnalysisMath
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_price_for_merchant(id)
    merchant_items = @sales_engine.find_all_items_by_merchant_id(id)
    prices = get_item_prices(merchant_items)
    mean(prices)
  end

  def average_price_per_merchant
    all_merchants = @sales_engine.all_merchants
    total_average_price = all_merchants.reduce(0) do |result, merchant|
      result += average_price_for_merchant(merchant.id)
      result
    end
    average_price = total_average_price / all_merchants.count
  end

  def price_standard_deviation_for_merchant(id)
    merchant_items = @sales_engine.find_all_items_by_merchant_id(id)
    prices = get_item_prices(merchant_items)
    standard_deviation(prices)
  end

  def price_standard_deviation
    all_prices = get_item_prices(@sales_engine.all_items)
    standard_deviation(all_prices)
  end

  def get_item_prices(items)
    items.map do |item|
      item.unit_price
    end
  end

  def golden_items
    @sales_engine.all_items.find_all do |item|
      item.unit_price > (average_price_per_merchant + price_standard_deviation)
    end
  end

end

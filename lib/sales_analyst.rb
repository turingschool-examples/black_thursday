require 'bigdecimal'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def items_per_merchant
    merchants_items = sales_engine.get_all_merchant_items.values
    merchants_items.map do |merchant_items|
      BigDecimal.new(merchant_items.count)
    end
  end

  def average_items_per_merchant
    (items_per_merchant.sum / items_per_merchant.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    variance = items_per_merchant.map do |number_of_items|
      ((average_items_per_merchant - number_of_items).abs) ** 2
    end.sum / (items_per_merchant.count - 1)
    Math.sqrt(variance).round(2)
  end

  def merchants_with_high_item_count
    stdev = average_items_per_merchant_standard_deviation
    sales_engine.get_all_merchant_items.map do |merchant, items|
      merchant if items.count > average_items_per_merchant + stdev
    end.compact
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_prices = sales_engine.get_one_merchant_prices(merchant_id)
    merchant_prices.sum / merchant_prices.count
  end

  def average_average_price_per_merchant
    merchants_prices = sales_engine.get_all_merchant_prices.values
    full_average = merchants_prices.map do |merchant_prices|
      merchant_prices.sum / merchant_prices.count
    end.sum / merchants_prices.count
    full_average.round(2)
  end

  def all_item_prices
    sales_engine.get_all_merchant_prices.values.flatten
  end

  def average_item_price
    all_item_prices.sum / all_item_prices.count
  end

  def item_prices_standard_deviation
    variance = all_item_prices.map do |item_price|
      ((average_item_price - item_price).abs) ** 2
    end.sum / (all_item_prices.count - 1)
    Math.sqrt(variance).round(2)
  end

  def golden_prices
    golden_limit = average_item_price + (2 * item_prices_standard_deviation)
    all_item_prices.select do |item_price|
      item_price >= golden_limit
    end
  end

  def golden_items
    golden_prices.map do |golden_price|
      sales_engine.search_ir_by_price(golden_price)
    end.flatten
  end

end

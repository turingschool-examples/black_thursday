require_relative 'statistics'
require_relative 'sales_engine'

class ItemsPriceAnalyst
  include Statistics

  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def all_merchants
    engine.merchants.all
  end

  def all_items
    engine.items.all
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = engine.merchants.find_by_id(merchant_id)
    item_prices = merchant.items.map { |i| i.unit_price }
    return 0 if item_prices == []
    BigDecimal(find_average(item_prices)).round(2)
  end

  def average_average_price_per_merchant
    merchant_ids = all_merchants.map {|m| m.id}
    average_prices = merchant_ids.map {|id| average_item_price_for_merchant(id)}
    BigDecimal(find_average(average_prices)).round(2)
  end

  def golden_items
    items_prices = all_items.map { |i| i.unit_price }
    threshold = (stdev(items_prices) * 2) + find_average(items_prices)
    all_items.find_all { |i| i.unit_price >= threshold }
  end

end
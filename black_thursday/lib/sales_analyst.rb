require 'bigdecimal'
require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    (count_items / count_merchants).round(2)
  end

  def average_item_price_for_merchant(id)
    BigDecimal.new(avg(id), 4).round(2)
  end

  def average_average_price_per_merchant
    average = @engine.merchants.all.map do |merchant|
      avg(merchant.id)
    end.sum
    BigDecimal.new(average / count_merchants, 4).round(2)
  end

  private
  def count_merchants
    @engine.merchants.all.count.to_f
  end

  def count_items
    @engine.items.all.count.to_f
  end

  def merchant_items_by_id(id)
    @engine.merchants.find_by_id(id).items
  end

  def sum_prices(id)
    merchant_items_by_id(id).map { |item| item.unit_price }.sum
  end

  def avg(id)
    sum_prices(id) / merchant_items_by_id(id).length
  end
end

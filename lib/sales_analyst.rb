require_relative 'find_functions'
require "pry"


class SalesAnalyst
  include FindFunctions
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def find_items_by_merchant_id(id)
    sales_engine.items.find_all_by_merchant_id(id)
  end

  def average_items_per_merchant
    (sales_engine.items.all.count.to_f / sales_engine.merchants.all.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(std_dev_numerator / std_dev_denominator).round(2)
  end

  def std_dev_numerator
    sales_engine.merchants.all.map do |merchant|
      distance_from_mean_squared(merchant.items.count)
    end.reduce(:+).to_f
  end

  def distance_from_mean_squared(item_count)
    ((item_count - average_items_per_merchant) ** 2).to_f
  end

  def std_dev_denominator
    (sales_engine.merchants.all.count - 1).to_f
  end

  def average_item_price_per_merchant(id)
    items = find_items_by_merchant_id(id)
    (items.map {|row|  row.unit_price}).reduce(:+) / items.count
  end

end

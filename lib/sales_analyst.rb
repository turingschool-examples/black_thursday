require 'bigdecimal'
require 'pry'

class SalesAnalyst
  attr_reader :sales_engine
  def initialize(se)
    @sales_engine = se
  end

  def average_items_per_merchant
    @total = 0
    @sales_engine.merchants.all.map do |merchant|
      @total += merchant.items.length
    end
    ((@total.to_f / @sales_engine.merchants.all.length.to_f) * 100).round / 100.0
  end

  def average_items_per_merchant_standard_deviation
    squares = number_of_items_for_each_merchant.map do |num|
      (num - average_items_per_merchant)**2
    end
    chaos = squares.sum / (@sales_engine.merchants.all.length - 1)
    Math.sqrt(chaos)
  end

  def number_of_items_for_each_merchant
    @sales_engine.merchants.all.map do |merchant|
      merchant.items.length
    end
  end

  def merchants_with_high_item_count
    @sales_engine.merchants.all.collect do |merchant|
      merchant if (merchant.items.length - average_items_per_merchant) > average_items_per_merchant_standard_deviation
    end.compact
  end

  def average_item_price_for_merchant(id)
    result = @sales_engine.pass_id_to_item_repo(id).map do |item|
      item.unit_price.to_f
    end.sum
    (result / @sales_engine.merchants.find_by_id(id).items.length * 100).round / 100.0
  end
end

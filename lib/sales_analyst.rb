require 'bigdecimal'
require 'pry'

# class for analytics on merchants and item prices
class SalesAnalyst
  attr_reader :sales_engine
  def initialize(se)
    @sales_engine = se
  end

  def merchants
    @sales_engine.merchants.all
  end

  def items
    @sales_engine.items.all
  end

  def average(numerator, denominator)
    (BigDecimal(numerator, 4) / BigDecimal(denominator, 4)).round(2)
  end

  def average_items_per_merchant
    average(items.length, merchants.length).to_f
  end

  def average_items_per_merchant_standard_deviation
    squares = number_of_items_for_every_merchant.map do |num|
      (num - average_items_per_merchant)**2
    end
    chaos = squares.sum / (merchants.length - 1)
    Math.sqrt(chaos)
  end

  def number_of_items_for_every_merchant
    merchants.map do |merchant|
      merchant.items.length
    end
  end

  def merchants_with_high_item_count
    merchants.collect do |merchant|
      difference = (merchant.items.length - average_items_per_merchant)
      merchant if difference > average_items_per_merchant_standard_deviation
    end.compact
  end

  def average_item_price_for_merchant(id)
    return 0 if find_items_with_merchant_id(id).length.zero?
    items = @sales_engine.pass_id_to_item_repo(id)
    prices = items.map(&:unit_price)
    average(prices.reduce(:+), items.length)
  end

  def find_items_with_merchant_id(id)
    @sales_engine.merchants.find_by_id(id).items
  end

  def average_average_price_per_merchant
    result = merchants.reduce(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id)
    end
    average(result, merchants.length)
  end

  # def golden_items
  #   result = @sales_engine.items.all.collect do |item|
  #     difference = (item.unit_price - average_average_price_per_merchant).to_f
  #     item if difference > average_items_per_merchant_standard_deviation * 2
  #   end.compact
  # end
end

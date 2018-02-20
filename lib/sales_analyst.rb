require 'bigdecimal'
require 'descriptive_statistics'

class SalesAnalyst
  attr_reader :sales_engine
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def items_per_merchant
    merchants = @sales_engine.merchants.all
    merchants.map do |merchant|
      merchant.items.count
    end
  end

  def average_items_per_merchant
    items_per_merchant.mean
  end

  def differences_squared
    items_per_merchant.map do |num|
      (num - average_items_per_merchant)**2
    end
  end

  def sum_of_differences_squared
    differences_squared.inject(0) { |sum, num| sum + num }
  end

  def average_items_per_merchant_standard_deviation
    divisor = items_per_merchant.count - 1
    Math.sqrt(sum_of_differences_squared / divisor).round(2)
  end

  def merchants_with_high_item_count
    zipped = items_per_merchant.zip(@sales_engine.merchants.all)
    average = average_items_per_merchant
    stdev = average_items_per_merchant_standard_deviation
    found = zipped.find_all { |merchant| merchant[0] > (average + stdev) }
    found.map { |merchant| merchant[1] }
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = @sales_engine.merchants.find_by_id(merchant_id)
    merchant_items = merchant.items
    item_average_price = merchant_items.map(&:unit_price).mean
    BigDecimal.new item_average_price.to_i
  end

  def average_average_price_per_merchant
    merchants = @sales_engine.merchants.all
    merchant_average_prices = merchants.map do |merchant|
      merchant_items = merchant.items
      merchant_items.map(&:unit_price).mean
    end
    BigDecimal.new merchant_average_prices.mean
  end
end

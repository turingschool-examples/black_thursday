require 'bigdecimal'
require 'ruby_native_statistics'
require 'descriptive_statistics'
require 'pry'

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

  def average_items_per_merchant_standard_deviation
    items_per_merchant.stdev.round(2)
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
    item_prices = merchant_items.map(&:unit_price)
    item_average_price = item_prices.mean
    BigDecimal.new(item_average_price, 6)
  end

  def average_average_price_per_merchant
    merchants = @sales_engine.merchants.all
    merchant_average_price = merchants.map do |merchant|
      if merchant.items.empty?
        0
      else
        average_item_price_for_merchant(merchant.id)
      end
    end.mean
    BigDecimal.new(merchant_average_price, 6)
  end

  def item_unit_prices
    items = @sales_engine.items.all
    items.map(&:unit_price)
  end

  def average_item_price
    item_unit_prices.mean.round(2)
  end

  def item_price_standard_deviation
    item_unit_prices.stdev.round(2)
  end

  def golden_items
    zipped = item_unit_prices.zip(@sales_engine.items.all)
    average = average_item_price
    stdev = item_price_standard_deviation
    found = zipped.find_all { |item| item[0] > (average + (stdev * 2)) }
    found.map { |item| item[1] }
  end
end

require 'bigdecimal'

class SalesAnalyst
  attr_reader :sales_engine
  def initialize(sales_engine)
    @sales_engine   = sales_engine
    @merchants      = sales_engine.merchants
    @merchant_items = items_per_merchant
    @all_items      = sales_engine.items.all
  end

  def items_per_merchant
    @merchants.all.map do |merchant|
      merchant.items.count
    end
  end

  def average_items_per_merchant
    count = @merchant_items.count
    average = @merchant_items.inject { |sum, num| sum + num }.to_f / count
    average.round(2)
  end

  def average_items_per_merchant_standard_deviation
    dif = @merchant_items.map { |num| (num - average_items_per_merchant)**2 }
    added = dif.inject { |sum, num| sum + num }.to_f
    Math.sqrt(added / (items_per_merchant.count - 1)).round(2)
  end

  def merchants_with_high_item_count
    zipped = @merchant_items.zip(@merchants.all)
    average = average_items_per_merchant
    stdev = average_items_per_merchant_standard_deviation
    found = zipped.find_all { |merchant| merchant[0] > (average + stdev) }
    found.map { |merchant| merchant[1] }
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = @merchants.find_by_id(merchant_id)
    prices = merchant.items.map(&:unit_price)
    count = prices.count
    item_average_price = prices.inject { |sum, num| sum + num }.to_f / count
    BigDecimal.new item_average_price, 4
  end

  def find_average_price(merchant)
    if merchant.items.empty?
      0
    else
      average_item_price_for_merchant(merchant.id)
    end
  end

  def average_average_price_per_merchant
    prices = @merchants.all.map do |merchant|
      find_average_price(merchant)
    end
    count = prices.count
    average_average_price = prices.inject { |sum, num| sum + num }.to_f / count
    BigDecimal.new(average_average_price, 0).truncate 2
  end

  def item_unit_prices
    items = @all_items
    items.map(&:unit_price)
  end

  def average_item_price
    count = item_unit_prices.count
    item_unit_prices.inject { |sum, num| sum + num }.to_f / count.round(2)
  end

  def item_price_standard_deviation
    dif = item_unit_prices.map { |num| (num - average_item_price)**2 }
    added = dif.inject { |sum, num| sum + num }.to_f
    Math.sqrt(added / (item_unit_prices.count - 1)).round(2)
  end

  def golden_items
    zipped = item_unit_prices.zip(@all_items)
    average = average_item_price
    stdev = item_price_standard_deviation
    found = zipped.find_all { |item| item[0] > (average + (stdev * 2)) }
    found.map { |item| item[1] }
  end
end

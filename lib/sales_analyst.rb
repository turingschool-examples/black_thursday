require 'pry'
class SalesAnalyst

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    items = sales_engine.items.all.count.to_f
    merchants = sales_engine.merchants.all.count.to_f
    (items / merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(items_per_merchant_std_dev_numerator / items_per_merchant_std_dev_denominator).round(2)
  end

  def items_per_merchant_std_dev_numerator
    sales_engine.merchants.all.map do |merchant|
      items_per_merchant_distance_from_mean_squared(merchant.items.count)
    end.reduce(:+).to_f
  end

  def items_per_merchant_distance_from_mean_squared(item_count)
    ((item_count - average_items_per_merchant) ** 2).to_f
  end

  def items_per_merchant_std_dev_denominator
    (sales_engine.merchants.all.count - 1).to_f
  end

  def merchants_with_high_item_count
    avg     = average_items_per_merchant
    std_dev = average_items_per_merchant_standard_deviation
    sales_engine.merchants.all.find_all do |merchant|
      merchant.items.count > avg + std_dev
    end
  end

  def average_item_price_for_merchant(id)
    items = sales_engine.merchants.find_by_id(id).items
    return 0 if items.empty?
    prices = items.map do |row|
      row.unit_price
    end.reduce(:+) / items.count
    prices.round(2)
  end

  def average_average_price_per_merchant
    merchants = sales_engine.merchants.all
    (merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end.reduce(:+) / merchants.count).round(2)
  end

  def average_average_price_per_merchant_std_dev
    merchants = sales_engine.merchants.all
    (merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end.reduce(:+) / merchants.count).round(2)
  end

  def golden_items
    mean    = average_average_price_per_merchant
    std_dev = item_price_standard_deviation
    items = sales_engine.items.all
    items.find_all do |item| 
      item.unit_price > (mean + (std_dev * 2))
    end
  end

  def average_price
    sales_engine.items.all.map {|item| item.unit_price}.reduce(:+) / sales_engine.items.all.count
  end

  def item_price_standard_deviation
    items = sales_engine.items.all
    stdev = items.map do |item|
      (item.unit_price - average_price) ** 2
    end.reduce(:+) / (items.count - 1)
    Math.sqrt(stdev).round(2)
  end

end

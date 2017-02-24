require_relative './sales_engine'
class SalesAnalyst
  attr_reader :engine, :average, :merchant_items, :merchant_list, :all_item_prices, :average_price
  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    @average = (engine.items.all.count.to_f / engine.merchants.all.count.to_f).round(2)
  end

  def merchant_item_count
    engine.merchants.all.map do |merchant|
      merchant.items.count
    end
  end

  def average_items_per_merchant_standard_deviation
    average_items_per_merchant
    sum = merchant_item_count.inject(0) do |total, count|
      total + (count - average)**2
    end
    @sd = Math.sqrt(sum / (merchant_item_count.count - 1)).round(2)
  end

  def merchants_with_high_item_count
    average_items_per_merchant_standard_deviation
    engine.merchants.all.find_all do |merchant|
      merchant.items.count > @average + @sd
    end
  end

  def find_merchant_items(merchant_id)
    @merchant_items = engine.items.find_all_by_merchant_id(merchant_id)
  end

  def average_item_price_for_merchant(merchant_id)
    find_merchant_items(merchant_id)
    combined_price = merchant_items.inject(0) do |total, item|
      total + item.unit_price
    end
    (combined_price / merchant_items.count).round(2)
  end

  def find_all_merchants
    @merchant_list = engine.merchants.all
  end

  def average_average_price_per_merchant
    find_all_merchants
    combined_average = merchant_list.inject(0) do |total, merchant|
      total + average_item_price_for_merchant(merchant.id)
    end
    (combined_average / merchant_list.count).round(2)
  end

  def find_all_item_prices
    @all_item_prices = engine.items.all.map do |item|
      item.unit_price
    end
  end

  def average_item_price
    find_all_item_prices
    @average_price = (all_item_prices.inject(:+) / engine.items.all.count).round(2)
  end

  def average_item_price_standard_deviation
    find_all_item_prices
    average_item_price
    sum = all_item_prices.inject(0) do |total, price|
      total + (price - average_price)**2
    end
    @sd_price = Math.sqrt(sum / (all_item_prices.count - 1)).round(2)
  end

  def golden_items
    average_item_price_standard_deviation
    engine.items.all.find_all do |item|
      item.unit_price > @average_price + @sd_price * 2
    end
  end
end

require_relative 'sales_engine'
require_relative 'data_analysis'

class SalesAnalyst
  include DataAnalysis
  attr_reader :sales_engine, :merchants, :items

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @merchants = sales_engine.merchants
    @items = sales_engine.items
    @invoices = sales_engine.invoices
  end

  # merchant and item methods

  def average_items_per_merchant
    average_of_items(items.all.count, merchants.all.count)
  end

  def average_items_per_merchant_standard_deviation
    items_per_merchant = merchants.all.map { |merchant| merchant.items.count }
    std_dev_from_array(items_per_merchant)
  end

  def merchants_with_high_item_count
    min_item_count = average_items_per_merchant + average_items_per_merchant_standard_deviation
    merchants.all.find_all { |merchant| merchant.items.count > min_item_count }
  end

  def average_item_price_for_merchant(merchant_id)
    item_prices = merchants.find_by_id(merchant_id).items.map { |item| item.unit_price }
    (item_prices.inject(:+) / item_prices.count).round(2)
  end

  def average_average_price_per_merchant
    (merchants.all.inject(0) { |sum, merchant| sum + average_item_price_for_merchant(merchant.id) } / merchants.all.count).round(2)
  end

  def average_price_per_item_standard_deviation
    prices = items.all.collect { |item| item.unit_price_to_dollars }
    std_dev_from_array(prices)
  end

  def golden_items
    std_dev = average_price_per_item_standard_deviation
    mean = items.all.inject(0) {|sum, object| sum + object.unit_price_to_dollars } / sales_engine.items.all.count
    min_price = (std_dev + mean) * 2
    sales_engine.items.all.find_all do |item|
      item.unit_price > min_price
    end
  end

# Inovice Methods

  def average_invoices_per_merchant
  end

end

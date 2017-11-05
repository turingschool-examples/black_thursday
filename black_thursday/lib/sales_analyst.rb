require 'bigdecimal'
require_relative 'sales_engine'
require 'memoist'

class SalesAnalyst

  extend Memoist

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
      avg(merchant.id) if merchant.items.count != 0
    end.compact.sum
    (average / count_merchants).round(2)
  end

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

  def standard_deviation_of_item_price
    sum = engine.items.all.map do |item|
      (item.unit_price - average_average_price_per_merchant) ** 2
    end.sum
    Math.sqrt(sum / (count_items - 1)).round(2)
  end
  memoize :standard_deviation_of_item_price

  def average_items_per_merchant_standard_deviation
    mean = engine.merchants.all.map do |merchant|
      (merchant.items.length - average_items_per_merchant)**2
      end
    Math.sqrt(mean.sum / (engine.merchants.all.count - 1)).round(2)
  end
  memoize :average_items_per_merchant_standard_deviation

  def one_standard_deviation_of_merchant_items
    (average_items_per_merchant + average_items_per_merchant_standard_deviation)
  end
  memoize :one_standard_deviation_of_merchant_items

  def merchants_with_high_item_count
    engine.merchants.all.find_all do |merchant|
      merchant.items.length > one_standard_deviation_of_merchant_items
    end
  end

  def merchants_with_no_items
    engine.merchants.all.find_all do |merchant|
      merchant.items.count == 0
    end
  end

  def names_of_merchants_without_items
    merchants_with_no_items.map do |merchant|
      merchant.name
    end
  end

  def merchants_with_one_or_more_items
    engine.merchants.all.find_all do |merchant|
      merchant.items.length > 0
    end
  end

  def names_of_merchants_with_at_least_one_item
    merchants_with_one_or_more_items.map do |merchant|
      merchant.name
    end
  end

  def two_standard_deviations_above_price
    average_average_price_per_merchant + (standard_deviation_of_item_price * 2)
  end
  memoize :two_standard_deviations_above_price

  def golden_items
    engine.items.all.find_all do |item|
      item.unit_price > two_standard_deviations_above_price
    end
  end
  memoize :golden_items

  def average_invoices_per_merchant
    (engine.invoices.all.count.to_f / count_merchants).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    sums = engine.merchants.all.map do |merchant|
      (merchant.invoices.length - average_invoices_per_merchant)**2
    end.sum
    Math.sqrt(sums / (engine.merchants.all.count - 1)).round(2)
  end
  memoize :average_invoices_per_merchant_standard_deviation
end

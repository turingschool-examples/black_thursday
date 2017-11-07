require 'bigdecimal'
require_relative 'sales_engine'
require 'memoist'
require "time"

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

  def two_invoices_per_merchant_standard_deviations
    average_invoices_per_merchant + (average_invoices_per_merchant_standard_deviation * 2)
  end
  memoize :two_invoices_per_merchant_standard_deviations

  def top_merchants_by_invoice_count
    engine.merchants.all.find_all do |merchant|
      merchant.invoices.count > two_invoices_per_merchant_standard_deviations
    end
  end
  memoize :top_merchants_by_invoice_count

  def two_standard_deviations_below_invoice_count
    average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2)
  end

  def bottom_merchants_by_invoice_count
    engine.merchants.all.find_all do |merchant|
      merchant.invoices.count < two_standard_deviations_below_invoice_count
    end
  end
  memoize :bottom_merchants_by_invoice_count

  def invoice_days_count
    engine.invoices.all.map do |invoice|
      invoice.created_at.strftime('%A')
    end
  end

  def days
    invoice_days_count.uniq
  end

  def days_count_by_day
    days.zip(days_of_week_count)
  end

  def days_of_week_count
    days.map {|day| invoice_days_count.count(day)}
  end

  def average_invoices_by_day
    days_of_week_count.sum / 7
  end

  def squares_of_day_counts
    days_of_week_count.map do |count|
      (count - average_invoices_by_day) ** 2
    end
  end

  def standard_deviation_of_invoices_by_day
    Math.sqrt(squares_of_day_counts.sum.to_f / days_of_week_count.length).ceil
  end
  memoize :standard_deviation_of_invoices_by_day

  def one_standard_deviation_of_days
    average_invoices_by_day + standard_deviation_of_invoices_by_day
  end
  memoize :one_standard_deviation_of_days

  def top_days_by_invoice_count
    top = days_count_by_day.find_all do |day|
      day[1] > one_standard_deviation_of_days
    end
    top.map {|day| day[0]}
  end
  memoize :top_days_by_invoice_count

  def invoice_status(status)
    all = engine.invoices.all.select do |invoice|
       invoice.status.to_sym == status
     end
     ((all.count.to_f / engine.invoices.all.count) * 100).round(2)
  end

end

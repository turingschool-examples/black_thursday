require 'memoist'
require_relative "sales_engine"

class SalesAnalyst
  extend Memoist

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine        = sales_engine
  end

  def average_items_per_merchant
    merchants = sales_engine.merchants.all.length
    items = sales_engine.items.all.length
    (items.to_f / merchants.to_f).round(2)
  end
  memoize :average_items_per_merchant

  def merchant_list
    sales_engine.merchants.merchants.map { |merchant| merchant.id }
  end
  memoize :merchant_list

  def find_items
    merchant_list.map do |merchant|
      sales_engine.items.find_all_by_merchant_id(merchant).count
    end
  end
  memoize :find_items

  def find_standard_dev_difference_total
    find_items.map do |item_total|
      (item_total - average_items_per_merchant) ** 2
    end.sum.round(2)
  end
  memoize :find_standard_dev_difference_total

  def total_std_dev_sum_minus_one
    find_standard_dev_difference_total / (merchant_list.count - 1)
  end
  memoize :total_std_dev_sum_minus_one

  def average_items_per_merchant_standard_deviation
    (Math.sqrt(total_std_dev_sum_minus_one).round(2))
  end
  memoize :average_items_per_merchant_standard_deviation

  def merchants_by_item_count
    Hash[merchant_list.zip(find_items)]
  end
  memoize :merchants_by_item_count

  def standard_dev_plus_average
    average_items_per_merchant_standard_deviation + average_items_per_merchant
  end
  memoize :standard_dev_plus_average

  def merchants_by_items_in_stock
    merchants_by_item_count.find_all do |_, value|
      value >= standard_dev_plus_average
    end
  end
  memoize :merchants_by_items_in_stock

  def merchants_with_high_item_count
    merchants_by_items_in_stock.map do |merchant|
      sales_engine.merchants.find_by_id(merchant[0])
    end
  end
  memoize :merchants_with_high_item_count

  def all_merchant_items(merchant_id)
    sales_engine.items.find_all_by_merchant_id(merchant_id)
  end
  memoize :all_merchant_items

  def average_item_price_for_merchant(merchant_id)
    list = all_merchant_items(merchant_id)
    list.reduce(0) do |sum, item|
      sum + item.unit_price / list.count
    end.round(2)
  end
  memoize :average_item_price_for_merchant

  def average_average_price_per_merchant
    (merchant_list.reduce(0) { |sum, merchant|
      sum + average_item_price_for_merchant(merchant)
      } / merchant_list.count).round(2)
  end
  memoize :average_average_price_per_merchant

  def average_unit_price
    (sales_engine.items.all.reduce(0) { |sum, item|
      sum + item.unit_price } / sales_engine.items.all.count).round(2).to_f
  end
  memoize :average_unit_price

  def unit_price_and_average_sqr_sum
    sales_engine.items.all.reduce(0) { |sum, item|
      sum += (item.unit_price - average_unit_price) ** 2 }
  end
  memoize :unit_price_and_average_sqr_sum

  def unit_price_std_dev_sum_minus_one
    unit_price_and_average_sqr_sum / (sales_engine.items.all.count - 1)
  end
  memoize :unit_price_std_dev_sum_minus_one

  def unit_price_stnd_dev
    Math.sqrt(unit_price_std_dev_sum_minus_one).round(2)
  end
  memoize :unit_price_stnd_dev

  def golden_items_stnd_dev
    average_unit_price + (unit_price_stnd_dev * 2)
  end
  memoize :golden_items_stnd_dev

  def golden_items
    sales_engine.items.items.find_all do |item|
      item.unit_price >= golden_items_stnd_dev
    end
  end
  memoize :golden_items

  def find_invoices
    merchant_list.map do |merchant|
      sales_engine.invoices.find_all_by_merchant_id(merchant).count
    end
  end
  memoize :find_invoices

  def average_invoices_per_merchant
    (find_invoices.reduce(0) { |sum, totals|
      sum += totals } / find_invoices.count.to_f).round(2)
  end
  memoize :average_invoices_per_merchant

  def invoice_total_minus_average_squared
    find_invoices.reduce(0) { |sum, total|
      sum += (total - average_invoices_per_merchant) ** 2 }
  end
  memoize :invoice_total_minus_average_squared

  def invoice_diff_total_divided
    invoice_total_minus_average_squared / (find_invoices.length - 1)
  end
  memoize :invoice_diff_total_divided

  def average_invoices_per_merchant_standard_deviation
    Math.sqrt(invoice_diff_total_divided).round(2)
  end
  memoize :average_invoices_per_merchant_standard_deviation

  def invoice_count_two_stnd_deviations_above_mean
    average_invoices_per_merchant + average_invoices_per_merchant_standard_deviation * 2
  end
  memoize :invoice_count_two_stnd_deviations_above_mean

  def invoice_count_two_stnd_deviations_below_mean
    average_invoices_per_merchant - average_invoices_per_merchant_standard_deviation * 2
  end
  memoize :invoice_count_two_stnd_deviations_below_mean

  def merchants_invoice_total_list
    Hash[merchant_list.zip(find_invoices)]
  end
  memoize :merchants_invoice_total_list

  def top_merchants
    sum = invoice_count_two_stnd_deviations_above_mean
    merchants_invoice_total_list.find_all { |key, value|
      key if value >= sum }
  end
  memoize :top_merchants

  def top_merchants_by_invoice_count
    top_merchants.map { |merchant|
      sales_engine.merchants.find_by_id(merchant.first) }
  end
  memoize :top_merchants_by_invoice_count

  def bottom_merchants
    sum = invoice_count_two_stnd_deviations_below_mean
    merchants_invoice_total_list.find_all { |key, value|
      key if value <= sum }
  end
  memoize :bottom_merchants

  def bottom_merchants_by_invoice_count
    bottom_merchants.map { |merchant|
      sales_engine.merchants.find_by_id(merchant.first) }
  end
  memoize :bottom_merchants_by_invoice_count

  def created_days_to_week_days
    sales_engine.invoices.invoices.map do |invoice|
      invoice.created_at.strftime("%A")
    end
  end
  memoize :created_days_to_week_days

  def invoice_totals_by_day
    created_days_to_week_days.each_with_object(Hash.new(0)) do |week_day, hash|
      hash[week_day] += 1
    end
  end
  memoize :invoice_totals_by_day

  def invoices_per_day_average
    invoice_totals_by_day.reduce(0) { |sum, (_, value)|
      sum += value } / invoice_totals_by_day.count
  end
  memoize :invoices_per_day_average

  def invoice_totals_minus_avg_sqrd
    invoice_totals_by_day.reduce(0) { |sum, (_, value)|
    sum += (value - invoices_per_day_average) ** 2 }
  end
  memoize :invoice_totals_minus_avg_sqrd

  def invoice_total_diff_sqrd
    invoice_totals_minus_avg_sqrd / (invoice_totals_by_day.count - 1)
  end
  memoize :invoice_total_diff_sqrd

  def weekday_invoice_stnd_deviation
    Math.sqrt(invoice_total_diff_sqrd).round(2)
  end
  memoize :weekday_invoice_stnd_deviation

  def weekday_invoice_stnd_deviation_plus_avg
    weekday_invoice_stnd_deviation + invoices_per_day_average
  end
  memoize :weekday_invoice_stnd_deviation_plus_avg

  def top_days_by_invoice_count
    invoice_totals_by_day.select do |key, value|
      value >= weekday_invoice_stnd_deviation_plus_avg
    end.keys
  end
  memoize :top_days_by_invoice_count

  def all_invoices_by_status(status)
    sales_engine.invoices.find_all_by_status(status)
  end
  memoize :all_invoices_by_status

  def invoice_status(status)
    (all_invoices_by_status(status).length /
    sales_engine.invoices.all.length.to_f * 100).round(2)
  end
  memoize :invoice_status
end

require 'pry'
require 'bigdecimal'
require_relative 'statistics'

class SalesAnalyst
  include Statistics

  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def all_merchants
    engine.merchants.all
  end

  def all_items
    engine.items.all
  end

  def merchant_item_count
    engine.merchants.merchant_item_count
  end

  def merchant_invoice_count
    engine.merchants.all.map { |merchant| merchant.invoices.count }
  end

  def average_items_per_merchant
    find_average(merchant_item_count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    stdev(merchant_item_count).round(2)
  end

  def merchants_with_high_item_count
    threshold = stdev(merchant_item_count) + find_average(merchant_item_count)
    merchant_outliers = all_merchants.find_all { |merchant| merchant.items.count > threshold }
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = engine.merchants.find_by_id(merchant_id)
    item_prices = merchant.items.map { |item| item.unit_price }
    BigDecimal(find_average(item_prices)).round(2)
  end

  def average_average_price_per_merchant
    merchant_ids = all_merchants.map {|merchant| merchant.id}
    average_merchant_prices = merchant_ids.map { |id| average_item_price_for_merchant(id)}
    BigDecimal(find_average(average_merchant_prices)).round(2)
  end

  def golden_items
    items_prices = all_items.map { |item| item.unit_price }  
    threshold = (stdev(items_prices) * 2) + find_average(items_prices)
    all_items.find_all { |item| item.unit_price >= threshold }
  end

  def average_invoices_per_merchant
    find_average(merchant_invoice_count).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    stdev(merchant_invoice_count).round(2)
  end

  def top_merchants_by_invoice_count
    threshold = (stdev(merchant_invoice_count) * 2) + find_average(merchant_invoice_count)
    all_merchants.find_all { |merchant| merchant.invoices.count > threshold }
  end

  def bottom_merchants_by_invoice_count
    threshold = find_average(merchant_invoice_count) - (stdev(merchant_invoice_count) * 2)
    all_merchants.find_all { |merchant| merchant.invoices.count < threshold }
  end

  def top_days_by_invoice_count
    day_hash = engine.invoices.all.group_by {|invoice| invoice.created_at.wday}
    day_data = day_hash.values.map { |day| day.count}
    threshold = (stdev(day_data) + find_average(day_data)).round
    top_days = day_hash.keys.find_all { |day| day_hash[day].count > threshold }
    top_days.map { |day| day_accessor[day] }
  end

  def day_accessor
    {0 => "Sunday", 1 => "Monday", 2 => "Tuesday", 3 => "Wednesday", 4 => "Thursday", 5 => "Friday", 6 => "Saturday"}
  end

  def invoice_status(status_symbol)
    numerator = engine.invoices.find_all_by_status(status_symbol).count
    denominator = engine.invoices.all.count
    ((numerator.to_f / denominator) * 100).round(2)
  end

end
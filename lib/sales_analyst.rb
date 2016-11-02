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
    BigDecimal.new(find_average(item_prices).round(2), 2)
  end

  def average_average_price_per_merchant
    merchant_ids = all_merchants.map {|merchant| merchant.id}
    average_merchant_prices = merchant_ids.map { |id| average_item_price_for_merchant(id)}
    BigDecimal.new(find_average(average_merchant_prices).round(2), 2)
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

end
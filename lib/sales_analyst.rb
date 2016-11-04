require_relative '../lib/statistics'
require 'date'

class SalesAnalyst

  include Statistics

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def items
    sales_engine.all_items
  end

  def merchants
    sales_engine.all_merchants
  end

  def invoices
    sales_engine.all_invoices
  end

  def average_items_per_merchant
    (items.count / merchants.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    array1   = merchants.map {|merchant| merchant.items.count}
    array2   = merchants
    average  = average_items_per_merchant
    standard_deviation(array1, array2, average)
  end

  def merchants_with_high_item_count
    mean    = average_items_per_merchant
    std_dev = average_items_per_merchant_standard_deviation
    merchants.find_all do |merchant|
      merchant.items.count > (mean + std_dev)
    end
  end

  def average_item_price_for_merchant(id)
    merch_items = sales_engine.merchants.find_by_id(id).items
    return 0 if merch_items.empty?
    prices = merch_items.map do |row|
      row.unit_price
    end.reduce(:+) / merch_items.count
    prices.round(2)
  end

  def average_average_price_per_merchant
    sum = merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end.reduce(:+)
    (sum / merchants.count).round(2)
  end

  def golden_items
    mean    = average_item_price
    std_dev = item_price_standard_deviation
    items.find_all do |item|
      item.unit_price > (mean + (std_dev * 2))
    end
  end

  def average_item_price
    sum = items.map { |item| item.unit_price }.reduce(:+)
    sum / items.count
  end

  def item_price_standard_deviation
    array1  = items.map {|item| item.unit_price}
    array2  = items
    average = average_item_price
    standard_deviation(array1, array2, average)
  end

  def average_invoices_per_merchant
    (invoices.count / merchants.count.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    array1   = merchants.map {|merchant| merchant.invoices.count}
    array2   = merchants
    average  = average_invoices_per_merchant
    standard_deviation(array1, array2, average)
  end

  def top_merchants_by_invoice_count
    mean    = average_invoices_per_merchant
    std_dev = average_invoices_per_merchant_standard_deviation
    merchants.find_all do |merchant|
      merchant.invoices.count > (mean + (std_dev * 2))
    end
  end

  def bottom_merchants_by_invoice_count
    mean    = average_invoices_per_merchant
    std_dev = average_invoices_per_merchant_standard_deviation
    merchants.find_all do |merchant|
      merchant.invoices.count < (mean - (std_dev * 2))
    end
  end

  def top_days_by_invoice_count
    mean    = average_invoices_per_day
    std_dev = average_invoices_per_day_standard_deviation
    invoices_by_day.find_all do |key, value|
      value > (mean + std_dev)
    end.map{|pair| pair[0]}
  end

  def invoices_by_day
    invoice_days.reduce ({}) do |result, day|
      result[day] += 1 if result[day]
      result[day]  = 1 if result[day].nil?
      result
    end
  end

  def invoice_days
    invoices.map {|invoice| Date::DAYNAMES[invoice.created_at.wday]}
  end

  def average_invoices_per_day
    sum = invoices_by_day.values.reduce(:+)
    (sum / invoices_by_day.values.count.to_f).round(2)
  end

  def average_invoices_per_day_standard_deviation
    array1  = invoices_by_day.values
    average = average_invoices_per_day
    standard_deviation(array1, average)
  end

  def invoice_status(invoice_status)
    status = all_invoices_by_status(invoice_status).count.to_f
    count  = invoices.count.to_f
    ((status / count) * 100).round(2)
  end

  def all_invoices_by_status(invoice_status)
    invoices.find_all do |row|
      row.status.to_sym == invoice_status.to_sym
    end
  end

end

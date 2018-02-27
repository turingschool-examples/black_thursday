require 'bigdecimal'
require 'pry'
require_relative 'customer_analytics_module'

# class for analytics on merchants and item prices
class SalesAnalyst
  include CustomerAnalytics

  attr_reader :sales_engine
  def initialize(se)
    @sales_engine    = se
    @std_dev_price   = average_items_price_standard_deviation
    @std_dev_invoice = average_invoices_per_merchant_standard_deviation
  end

  def merchants
    @sales_engine.merchants.all
  end

  def items
    @sales_engine.items.all
  end

  def invoices
    @sales_engine.invoices.all
  end

  def customers
    @sales_engine.customers.all
  end

  def invoice_count
    merchants.map do |merchant|
      merchant.invoices.count
    end
  end

  def average(numerator, denominator)
    (BigDecimal(numerator, 4) / BigDecimal(denominator, 4)).round(2)
  end

  def standard_deviation(data, average)
    result = data.map do |item|
      (item - average)**2
    end.reduce(:+) / (data.length - 1)
    Math.sqrt(result)
  end

  def average_items_per_merchant
    average(items.length, merchants.length).to_f
  end

  def average_items_per_merchant_standard_deviation
    total_items = merchants.map { |merchant| merchant.items.length }
    standard_deviation(total_items, average_items_per_merchant).round(2)
  end

  def merchants_with_high_item_count
    average = average_items_per_merchant
    standard_deviation = average_items_per_merchant_standard_deviation
    merchants.collect do |merchant|
      difference = (merchant.items.length - average)
      merchant if difference > standard_deviation
    end.compact
  end

  def average_item_price_for_merchant(id)
    return 0 if find_items_with_merchant_id(id).length.zero?
    items = @sales_engine.pass_id_to_item_repo(id)
    prices = items.map(&:unit_price)
    average(prices.reduce(:+), items.length)
  end

  def find_items_with_merchant_id(id)
    @sales_engine.merchants.find_by_id(id).items
  end

  def average_average_price_per_merchant
    result = merchants.reduce(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id)
    end
    average(result, merchants.length)
  end

  def all_item_prices
    items.map(&:unit_price)
  end

  def average_items_price_standard_deviation
    standard_deviation(all_item_prices, average_average_price_per_merchant)
  end

  def golden_items
    average = average_average_price_per_merchant
    items.collect do |item|
      difference = (item.unit_price - average).to_f
      item if difference > @std_dev_price * 2
    end.compact
  end

  def average_invoices_per_merchant
    average(invoices.length, merchants.length).to_f
  end

  def average_invoices_per_merchant_standard_deviation
    total_invoices = merchants.map { |merchant| merchant.invoices.length }
    avg            = average_invoices_per_merchant
    standard_deviation(total_invoices, avg).round(2)
  end

  def top_merchants_by_invoice_count
    invoice_average   = average_invoices_per_merchant
    invoice_deviation = average_invoices_per_merchant_standard_deviation
    top_merchants     = merchants.find_all do |merchant|
      merchant.invoices.count > ((invoice_deviation * 2) + invoice_average)
    end
    top_merchants
  end

  def bottom_merchants_by_invoice_count
    invoice_average   = average_invoices_per_merchant
    invoice_deviation = average_invoices_per_merchant_standard_deviation
    bottom_merchants  = merchants.find_all do |merchant|
      merchant.invoices.count < (invoice_average - (invoice_deviation * 2))
    end
    bottom_merchants
  end

  def invoice_dates
    invoices.map do |invoice|
      invoice.created_at.strftime('%A')
    end
  end

  def finding_number_of_invoices_per_day
    invoices_per_day = Hash.new(0)
    invoice_dates.each do |day|
      invoices_per_day[day] += 1
    end
    invoices_per_day
  end

  def average_invoice_per_day
    invoice_count.reduce(:+) / 7.0
  end

  def invoice_day_deviation
    days  = finding_number_of_invoices_per_day
    average = average_invoice_per_day
    total = days.map do |_day, count|
      (count - average)**2
    end
    Math.sqrt(total.reduce(:+) / (total.length - 1)).round(2)
  end

  def top_days_by_invoice_count
    average   = average_invoice_per_day
    deviation = invoice_day_deviation
    days      = finding_number_of_invoices_per_day
    days.select do |day, number|
      day if number > (deviation + average)
    end.keys
  end

  def invoice_status(status)
    total = 0
    invoices.each do |invoice|
      total += 1 if invoice.status == status
    end
    ((total.to_f / invoices.count.to_f) * 100).round(2)
  end
end

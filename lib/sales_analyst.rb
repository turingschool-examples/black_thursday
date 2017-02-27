require_relative 'sales_engine'
require_relative 'merchant'
require_relative 'calculator'
require 'bigdecimal'
require 'pry'

class SalesAnalyst

  include Calculator

  attr_reader :sales_engine

  def initialize (sales_engine)
    @sales_engine = sales_engine
  end

# ------ Data Structure Navigation ------
  def merchant_repository
    sales_engine.merchants
  end

  def item_repository
    sales_engine.items
  end

  def invoice_repository
    sales_engine.invoices
  end

# ----------- Search methods -----------

  def items_per_merchant
    merchant_repository.merchants.map { |merchant| merchant.items.length }
  end

  def price_of_items_per_merchant(merchant_id)
    item_array = item_repository.find_all_by_merchant_id(merchant_id)
    item_array.map { |item| item.unit_price }
  end

  def invoice_per_merchant
    merchant_repository.merchants.map { |merchant| merchant.invoices.length }
  end

  def price_per_item
    item_repository.items.map { |item| item.unit_price }
  end

  def average_price_per_item
    average(price_per_item)
  end

  def status_per_invoice
    invoice_repository.invoices.map { |invoice| invoice.status }
  end

  def number_for_day
    numbered_days = Hash.new()
    invoice_repository.invoices.each { |invoice| numbered_days[] }
  end
#------------------ Merchant Analyst ------------------

  def average_items_per_merchant
    average(items_per_merchant)

  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(items_per_merchant)
  end

  def merchants_with_high_item_count
    avg = average_items_per_merchant
    std_dev = average_items_per_merchant_standard_deviation

    merchant_repository.merchants.select do |merchant|
      merchant.items.length > (avg + std_dev)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    average(price_of_items_per_merchant(merchant_id))
  end

  def average_average_price_per_merchant
    price_averages = merchant_repository.merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    average(price_averages)
  end

  def golden_items
    price_std_dev = standard_deviation(price_per_item)
    item_repository.items.select { |item| item.unit_price > (price_std_dev * 2) }
  end

# ------------------Invoice Analyst------------------------
  def average_invoices_per_merchant
    average(invoice_per_merchant)
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(invoice_per_merchant)
  end

  def top_merchants_by_invoice_count
    avg = average_invoices_per_merchant
    std_dev = average_invoices_per_merchant_standard_deviation

    merchant_repository.merchants.select do |merchant|
      merchant.invoices.length > avg + (std_dev * 2)
    end
  end

  def bottom_merchants_by_invoice_count
    avg = average_invoices_per_merchant
    std_dev = average_invoices_per_merchant_standard_deviation

    merchant_repository.merchants.select do |merchant|
      merchant.invoices.length < avg + (std_dev * 2)
    end
  end

  def top_days_by_invoice_count
    binding.pry
    days = invoice_repository.invoices.map { |invoice| invoice.created_at.strftime("%A") }
    day_totals = days.each_with_object(Hash.new(0)) { |day, counts| counts[day] += 1 }
    day_totals.select {|key,value| value > sd }
  end

  def invoice_status(status)
    numerator = invoice_repository.find_all_by_status("#{status}")
    denominator = invoice_repository.invoices.length
    percentage(numerator, denominator)
  end
end

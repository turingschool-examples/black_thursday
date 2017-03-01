require_relative 'sales_engine'
require_relative 'merchant'
require_relative 'calculator'
require_relative 'merchant_analytics'
require 'bigdecimal'
require 'pry'

class SalesAnalyst

  include Calculator
  include MerchantAnalytics

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

  def invoice_item_repository
    sales_engine.invoice_items
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

  def invoice_days
    invoice_repository.invoices.map { |invoice| invoice.created_at.strftime("%A") }
  end

  def invoice_day_count
    days = invoice_days
    days.each_with_object(Hash.new(0)) { |day, counts| counts[day] += 1 }
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
      merchant.invoices.length < avg - (std_dev * 2)
    end
  end

  def top_days_by_invoice_count
    day_totals = invoice_day_count
    sd = average(day_totals.values) + standard_deviation(day_totals.values)
    top_days = day_totals.select { |key,value| value > sd }
    top_days.map { |day| day[0].to_s}
  end

  def invoice_status(status)
    numerator = invoice_repository.find_all_by_status(status)
    denominator = invoice_repository.invoices.length
    percentage(numerator, denominator)
  end

  def total_revenue_by_date(date)
    invoice_date = invoice_repository.find_all_by_date(date)
    invoice_date.reduce(0) { |sum, invoice| sum + invoice.total }
  end

  def top_revenue_earners(amount = nil)
    if amount == nil
      amount = 20
    else
      amount = amount
    end
    merchants = merchant_repository.merchants
    merchant_values = Hash[merchants.map { |merchant| [merchant, merchant.invoices]}]
    merchant_values.map { |merchant, total| merchant_values[merchant] =  total.reduce(0) { |sum, invoice| sum + invoice.total }}
    top_merchants = merchant_values.sort_by { |key,value| value }.reverse[0..(amount - 1)]
    top_merchants.map { |pair| pair[0] }

    # merchant_values.values.map { |invoice| invoice.reduce(0) { |sum, invoice| sum + invoice.total }}
  end

  def merchants_ranked_by_revenue
    merchants = merchant_repository.merchants
    merchant_values = Hash[merchants.map { |merchant| [merchant, merchant.invoices]}]
    merchant_values.map { |merchant, total| merchant_values[merchant] =  total.reduce(0) { |sum, invoice| sum + invoice.total }}
    top_merchants = merchant_values.sort_by { |key,value| value }.reverse.flatten
    top_merchants.select! { |merchant| merchant.class == Merchant }.flatten
  end

  def merchants_with_pending_invoices
    pending = sales_engine.invoices.invoices.select { |invoice| invoice.transactions.none? { |transaction| transaction.result == "success"}}
    pending.map { |invoice| invoice.merchant }.uniq
  end

  def merchants_with_only_one_item
    merchant_repository.all.select { |merchant| merchant.items.count == 1 }.compact
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_with_only_one_item.select { |merchant| merchant.created_at.strftime("%B") == month }
  end

  def most_sold_item_for_merchant(merchant_id)
# binding.pry
    merchant_invoices = invoice_repository.find_all_by_merchant_id(merchant_id)

    successfull_invoices = merchant_invoices.select do |invoice|
      invoice.mod_paid_in_full?
    end

    invoice_items = successfull_invoices.map do |invoice|
      invoice_item_repository.find_all_by_invoice_id(invoice.id)
    end.flatten

    most_sold = invoice_items.max_by do |invoice_item|
      invoice_item.quantity
    end

    top_invoice_item = invoice_items.select do |invoice_item|
      invoice_item.quantity == most_sold.quantity
    end
    
    top_invoice_item.map do |invoice_item|
      item_repository.find_by_id(invoice_item.item_id)
    end
  end

  def revenue_by_merchant(merchant_id)
    merchant_repository.find_by_id(merchant_id).paid_in_full_total
  end

  def best_item_for_merchant(merchant_id)
    merchant_invoices = invoice_repository.find_all_by_merchant_id(merchant_id)

    successfull_invoices = merchant_invoices.select do |invoice|
      invoice.mod_paid_in_full?
    end

    invoice_items = successfull_invoices.map do |invoice|
      invoice_item_repository.find_all_by_invoice_id(invoice.id)
    end.flatten

    best_item = invoice_items.max_by { |item| item.unit_price * item.quantity }
    item_repository.find_by_id(best_item.item_id)
  end
end

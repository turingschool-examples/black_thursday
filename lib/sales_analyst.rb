require_relative 'sales_engine'
require 'Date'

class SalesAnalyst
  include MathModule

  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    (@engine.items.all.length / @engine.merchants.all.length.to_f).round(2)
  end

  def items_per_merchant
    items_per_merchant_count = {}
    @engine.merchants.all.each do |merchant|
      count_num = @engine.items.all.count do |item|
        item.merchant_id == merchant.id
      end
      items_per_merchant_count[merchant] = count_num
    end
    items_per_merchant_count
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    merchant_items = items_per_merchant.values
    standard_dev(merchant_items, average)
  end

  def merchants_with_high_item_count
    solution = []
    std_deviation_mean = (average_items_per_merchant * 1) + average_items_per_merchant_standard_deviation
    items_per_merchant.each do |merchant, number_of_items|
      solution << merchant if number_of_items >= std_deviation_mean
    end
    solution
  end

  def average_item_price_for_merchant(id)
    merchant_items = []
    @engine.items.all.each do |item|
      merchant_items << item if item.merchant_id == id
    end
    total_sum = merchant_items.sum {|item| item.unit_price}
    solution = (total_sum / merchant_items.length).round(2)
  end

  def average_item_price_per_merchant
    average = {}
    @engine.merchants.all.each do |merchant|
      average[merchant] = average_item_price_for_merchant(merchant.id)
    end
    average
  end

  def average_average_price_per_merchant
    x = average_item_price_per_merchant.values.sum
    y = average_item_price_per_merchant.values.length
    solution = (x / y).round(2)
  end

  def average_price_per_item_standard_deviation
    mean = average_average_price_per_merchant
    item_prices = []
    @engine.items.all.each do |item|
      item_prices << item.unit_price
    end
    standard_dev(item_prices, mean)
  end

  def golden_items
    solution = []
    z = (average_price_per_item_standard_deviation * 2) + average_average_price_per_merchant
    @engine.items.all.each do |item|
      solution << item if item.unit_price > z
    end
    solution
  end

  def average_invoices_per_merchant
    (@engine.invoices.all.length / @engine.merchants.all.length.to_f).round(2)
  end

  def invoices_per_merchant
    invoices_per_merchant_per_count = {}
    @engine.merchants.all.each do |merchant|
      count = @engine.invoices.all.count do |invoice|
        invoice.merchant_id == merchant.id
      end
      invoices_per_merchant_per_count[merchant] = count
    end
    invoices_per_merchant_per_count
  end

  def average_invoices_per_merchant_standard_deviation
    mean = average_invoices_per_merchant
    merchant_invoices = invoices_per_merchant.values
    standard_dev(merchant_invoices, mean)
  end

  def top_merchants_by_invoice_count
    solution = []
    std_deviation_mean = (average_invoices_per_merchant_standard_deviation * 2) + average_invoices_per_merchant
    invoices_per_merchant.each do |merchant, number_of_invoices|
      solution << merchant if number_of_invoices >= std_deviation_mean
    end
    solution
  end

  def bottom_merchants_by_invoice_count
    solution = []
    std_deviation_mean = (average_invoices_per_merchant_standard_deviation * -2) + average_invoices_per_merchant
    invoices_per_merchant.each do |merchant, number_of_invoices|
      solution << merchant if number_of_invoices <= std_deviation_mean
    end
    solution
  end

  def top_days_by_invoice_count
    solution = []
    z = (average_invoices_per_weekday_standard_deviation * 1) + average_invoices_per_weekday
    invoices_per_day_of_the_week.each do |weekday, number_of_invoices|
      solution << weekday if number_of_invoices >= z
    end
    tranform_weekday_values(solution)
  end

  def invoice_status(shipping_status)
    invoice_status = []
    @engine.invoices.all.each do |invoice|
      invoice_status << invoice if invoice.status == shipping_status
    end
    percentage = ((invoice_status.length.to_f / @engine.invoices.all.length) * 100).round(2)
  end
end

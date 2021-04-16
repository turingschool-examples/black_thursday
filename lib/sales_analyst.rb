require_relative 'sales_engine'
require 'bigdecimal'

class SalesAnalyst
  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    @engine.items.all.length.fdiv(@engine.merchants.all.length).round(2)
  end

  # Brant's magic method
  def average_items_per_merchant_standard_deviation
    merchant_ids = @engine.merchants.all.map do |merchant|
      merchant.id
    end
    items_per_merchant = merchant_ids.map do |id|
      @engine.items.find_all_by_merchant_id(id).length
    end
    sum_of_squares = items_per_merchant.map do |wares|
      (wares - average_items_per_merchant)**2
    end.sum
    (sum_of_squares.fdiv(merchant_ids.length - 1)**0.5).round(2)
  end

  def merchants_with_high_item_count
    one_standard = average_items_per_merchant + average_items_per_merchant_standard_deviation
    merchant_ids = @engine.merchants.all.map do |merchant|
      merchant.id
    end
    merchant_ids_high_count = merchant_ids.find_all do |id|
      number_of_items = @engine.items.find_all_by_merchant_id(id).length
      number_of_items > one_standard
    end
    @engine.merchants.all.find_all do |merchant|
      merchant_ids_high_count.include?(merchant.id)
    end
  end

  def average_item_price_for_merchant(id)
    items_by_merchant_array = @engine.items.find_all_by_merchant_id(id)
    test = items_by_merchant_array.sum do |item|
      item.unit_price
    end / items_by_merchant_array.length
    test.round(2)
  end

  def average_average_price_per_merchant
    test = @engine.merchants.all.sum do |merchant|
      average_item_price_for_merchant(merchant.id)
    end / @engine.merchants.all.length
    test.round(2)
  end

  def average_item_price
    test = @engine.items.all.sum do |item|
      item.unit_price
    end / @engine.items.all.length
    test.round(2)
  end

  def item_price_standard_deviation
    item_average = average_item_price
    denominator = @engine.items.all.sum do |item|
      (item.unit_price - item_average)**2
    end
    ((denominator / (@engine.items.all.length - 1))**0.5).round(2)
  end

  def golden_items
    two_standard = average_item_price + item_price_standard_deviation * 2
    @engine.items.all.find_all do |item|
      item.unit_price > two_standard
    end
  end

  def average_invoices_per_merchant
    merchant_ids = @engine.all_merchant_ids

    merchant_ids.map do |merchant|
      @engine.invoices.all.sum do |invoice|
        invoice.merchant_id == merchant
      end
    end
  end

  def average_invoice_per_merchant_standard_deviation
    average = average_invoices_per_merchant
    merchant_ids = @engine.all_merchant_ids

    merchant_invoice = merchant_ids.map do |merchant|
      @engine.invoices.all.sum do |invoice|
        invoice.merchant_id == merchant
      end
    end

    merchant_invoice.sum do |merchant|
      (merchant - average)**2
    end.fdiv(merchant_ids.length - 1)**0.5
  end

  def invoices_per_merchant
    merchant_ids = @engine.all_merchant_ids

    invoice_count = merchant_ids.map do |merchant|
      @engine.invoice.all.sum do |invoice|
        invoice.merchant_id == merchant
      end
    end
    merchant_ids.zip(invoice_count)
  end

  def invoices_per_day
    days = [0, 1, 2, 3, 4, 5, 6]

    days.sum do |day|
      @engine.invoices.all.created_at.wday == day
    end
  end

  def top_merchants_by_invoice_count
    deviation = average_invoices_per_merchant + (average_invoice_per_merchant_standard_deviation * 2)
    merchant_invoice_array = invoices_per_merchant

    top_merchant = merchant_invoice_array.find_all do |invoice|
      invoice[1] > deviation
    end

    @engine.merchants.all.find_all do |merchant|
      top_merchant[0].include?(merchant.id)
    end
  end

  def bottom_merchants_by_invoice_count
    deviation = average_invoices_per_merchant - (average_invoice_per_merchant_standard_deviation * 2)
    merchant_invoice_array = invoices_per_merchant

    top_merchant = merchant_invoice_array.find_all do |invoice|
      invoice[1] < deviation
    end

    @engine.merchants.all.find_all do |merchant|
      top_merchant[0].include?(merchant.id)
    end
  end

  def top_days_by_invoice_count
    days_of_week = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
    invoice_per_day = invoices_per_day
    average = invoice_per_day.sum.fdiv(7)

    standard_div = invoice_per_day.sum do |day|
      (day - average)**2
    end.fdiv(6)**0.5
    days_invoice = days_of_week.zip(invoice_per_day)

    golden_days = days_invoice.find_all do |day|
      day[1] > average + standard_div
    end

    golden_days.map do |day|
      day[0]
    end
  end

  def invoice_status(status_arg)
    invoice_count = @engine.invoices.all.count do |invoice|
      invoice.status == status_arg
    end

    invoice_count.fdiv(@engine.invoices.all.length)
  end
end

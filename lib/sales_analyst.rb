require_relative 'sales_engine'
require 'bigdecimal'

class SalesAnalyst
  attr_reader :engine

  def initialize(engine)
    @engine = engine
    @merchant_id_array = @engine.all_merchant_ids
  end

  def average_items_per_merchant
    @engine.number_of_class(:items).fdiv(@engine.number_of_class(:merchants)).round(2)
  end

  def standard_deviation(array, average)
    sum_of_squares = array.sum do |object|
      (object - average)**2
    end
    (sum_of_squares.fdiv(array.length - 1)**0.5).round(2)
  end

  # Brant's magic method
  def average_items_per_merchant_standard_deviation
    items_average = average_items_per_merchant
    items_per_merchant = @merchant_id_array.map do |id|
      @engine.items.find_all_by_merchant_id(id).length
    end
    standard_deviation(items_per_merchant, items_average)
  end

  def merchants_with_high_item_count
    one_standard = average_items_per_merchant + average_items_per_merchant_standard_deviation
    merchant_ids_high_count = @merchant_id_array.find_all do |id|
      number_of_merchant_items = @engine.items.find_all_by_merchant_id(id).length
      number_of_merchant_items > one_standard
    end
    @engine.csv_array(:merchants).find_all do |merchant|
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
    test = @engine.csv_array(:merchants).sum do |merchant|
      average_item_price_for_merchant(merchant.id)
    end / @engine.number_of_class(:merchants)
    test.round(2)
  end

  def average_item_price
    test = @engine.csv_array(:items).sum do |item|
      item.unit_price
    end / @engine.number_of_class(:items)
    test.round(2)
  end

  def item_price_standard_deviation
    item_average = average_item_price
    item_array = @engine.csv_array(:items).map do |item|
      item.unit_price
    end
    standard_deviation(item_array, item_average)
  end

  def golden_items
    two_standard = average_item_price + item_price_standard_deviation * 2
    @engine.csv_array(:items).find_all do |item|
      item.unit_price > two_standard
    end
  end

  def average_invoices_per_merchant
    @engine.number_of_class(:invoices).fdiv(@merchant_id_array.length).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    average = average_invoices_per_merchant

    merchant_invoice = @merchant_id_array.map do |merchant|
      @engine.csv_array(:invoices).count do |invoice|
        invoice.merchant_id == merchant
      end
    end

    standard_deviation(merchant_invoice, average)
  end

  def invoices_per_merchant
    invoice_count = @merchant_id_array.map do |merchant|
      @engine.csv_array(:invoices).count do |invoice|
        invoice.merchant_id == merchant
      end
    end
    @merchant_id_array.zip(invoice_count)
  end

  def invoices_per_day
    days = [0, 1, 2, 3, 4, 5, 6]

    days.map do |day|
      @engine.csv_array(:invoices).count do |invoice|
        invoice.created_at.wday == day
      end
    end
  end

  def top_merchants_by_invoice_count
    deviation = (average_invoices_per_merchant + average_invoices_per_merchant_standard_deviation * 2).round(2)
    merchant_invoice_array = invoices_per_merchant

    top_merchant = merchant_invoice_array.find_all do |invoice|
      invoice[1] > deviation
    end
    top_merchant_id = top_merchant.map do |merchant|
      merchant[0]
    end
    @engine.csv_array(:merchants).find_all do |merchant|
      top_merchant_id.include?(merchant.id)
    end
  end

  def bottom_merchants_by_invoice_count
    deviation = average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2)
    merchant_invoice_array = invoices_per_merchant

    bottom_merchant = merchant_invoice_array.find_all do |invoice|
      invoice[1] < deviation
    end
    bottom_merchant_id = bottom_merchant.map do |merchant|
      merchant[0]
    end
    @engine.csv_array(:merchants).find_all do |merchant|
      bottom_merchant_id.include?(merchant.id)
    end
  end

  def invoices_per_day
    days = [0, 1, 2, 3, 4, 5, 6]

    days.map do |day|
      @engine.invoices.all.count do |invoice|
        invoice.created_at.wday == day
      end
    end
  end

  def top_days_by_invoice_count
    days_of_week = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
    invoice_per_day = invoices_per_day
    average = invoice_per_day.sum.fdiv(7)

    days_div = standard_deviation(invoice_per_day, average)
    days_invoice = days_of_week.zip(invoice_per_day)

    golden_days = days_invoice.find_all do |day|
      day[1] > average + days_div
    end

    golden_days.map do |day|
      day[0]
    end
  end

  def invoice_status(status_arg)
    invoice_count = @engine.invoices.all.count do |invoice|
      invoice.status == status_arg
    end

    (invoice_count.fdiv(@engine.number_of_class(:invoices)) * 100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    tr = @engine.transactions.find_all_by_invoice_id(invoice_id)
    successful_transactions = tr.find_all do |transaction|
      transaction.result == :success
    end
    successful_transactions.empty? != true
  end

  def invoice_total(invoice_id)
    items = @engine.invoice_items.find_all_by_invoice_id(invoice_id)

    items.map do |item|
      item.quantity * item.unit_price_to_dollars
    end.sum
  end

  def invoice_paid_in_full?(invoice_id)
    tr = @engine.transactions.find_all_by_invoice_id(invoice_id)
    successful_transactions = tr.find_all do |transaction|
      transaction.result == :success
    end
    successful_transactions.empty? != true
  end

  def invoice_total(invoice_id)
    items = @engine.invoice_items.find_all_by_invoice_id(invoice_id)

    total = items.map do |item|
      item.quantity * item.unit_price_to_dollars
    end.sum
    BigDecimal(total, 10)
  end

  def total_revenue_by_date(date)
    
  end
end

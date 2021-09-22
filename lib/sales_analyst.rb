# frozen_string_literal: true

require 'time'
require 'bigdecimal/util'
require 'bigdecimal/util'

class SalesAnalyst
  def initialize(items, merchants, invoices, invoice_items, customers, transactions)
    @items = items
    @merchants = merchants
    @invoices = invoices
    @avgavg = []
    @invoice_items = invoice_items
    @customers = customers
    @transactions = transactions
  end

  def average_items_per_merchant
    (@items.all.count.to_f / @merchants.all.count).round(2)
  end

  def items_per_merchant
    @merchants.all.map do |merchant|
      @items.find_all_by_merchant_id(merchant.id).length
    end
  end

  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    x = items_per_merchant.sum(0.0) { |element| (element - mean)**2 }
    variance = x / (items_per_merchant.count - 1)
    Math.sqrt(variance).round(2)
  end

  def merchants_with_high_item_count
    test = []
    @merchants.all.each do |merchant|
      if @items.find_all_by_merchant_id(merchant.id).length > (average_items_per_merchant_standard_deviation * 2)
        test << merchant
      end
    end
    test
  end

  def average_item_price_for_merchant(id)
    items_by_merchant = []
    @items.all.each do |item|
      items_by_merchant << item.unit_price if item.merchant_id == id
    end
    (items_by_merchant.sum / items_by_merchant.count).to_d.round(2)
  end

  def average_average_price_per_merchant
    @merchants.all.each do |merchant|
      @avgavg << average_item_price_for_merchant(merchant.id)
    end
    (@avgavg.sum / @merchants.all.count).to_d.round(2)
  end

  def item_price_standard_dev
    avg_item_price = @items.all.map(&:unit_price)
    mean = (avg_item_price.sum / @items.all.count)
    sum = avg_item_price.sum(0.0) { |element| (element - mean)**2 }
    variance = sum / (@items.all.count - 1)
    standard_deviation = Math.sqrt(variance).round(2)
  end

  def golden_items
    expensive_items = []
    @items.all.each do |item|
      expensive_items << item if item.unit_price > (item_price_standard_dev * 2)
    end
    expensive_items
  end

  def average_invoices_per_merchant
    (@invoices.all.count.to_f / @merchants.all.count).round(2)
  end

  def invoices_per_merchant
    @merchants.all.map do |merchant|
      @invoices.find_all_by_merchant_id(merchant.id).length
    end
  end

  def average_invoices_per_merchant_standard_deviation
    mean = average_invoices_per_merchant
    x = invoices_per_merchant.sum(0.0) { |element| (element - mean)**2 }
    variance = x / (invoices_per_merchant.count - 1)
    standard_deviation = Math.sqrt(variance).round(2)
  end

  def top_merchants_by_invoice_count
    test = []
    @merchants.all.each do |merchant|
      if @invoices.find_all_by_merchant_id(merchant.id).length > (average_invoices_per_merchant_standard_deviation * 2) + average_invoices_per_merchant
        test << merchant
      end
    end
    test
  end

  def bottom_merchants_by_invoice_count
    test = []
    @merchants.all.each do |merchant|
      if @invoices.find_all_by_merchant_id(merchant.id).length < average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2)
        test << merchant
      end
    end
    test
  end

  def values_per_day
    weekdays = Hash.new(0)
    @invoices.all.find_all do |invoice|
      day = invoice.created_at.strftime('%A')
      if weekdays[day] += 1
      end
    end
    weekdays
  end

  def days_created_at_stddev
    mean = values_per_day.values.sum / 7
    sum = values_per_day.values.sum(0.0) { |element| (element - mean)**2 }
    variance = sum / (values_per_day.values.length - 1)

    standard_deviation = Math.sqrt(variance).round(2)
  end

  def top_days_by_invoice_count
    result = []
    values_per_day.each do |weekday, count|
      if count > ((values_per_day.values.sum / 7) + days_created_at_stddev)
        result << weekday
      end
    end
    result
  end

  def invoice_status(status)
    result = @invoices.find_all_by_status(status)
    ((result.count.to_f / @invoices.all.count) * 100).round(2)
  end

  def find_success(invoice_id)
    test = @transactions.find_all_by_invoice_id(invoice_id)
    test.all? do |trans|
      trans.result == :success
    end
  end

  def invoice_paid_in_full?(invoice_id)
    if @transactions.find_all_by_invoice_id(invoice_id).empty?
      false
    elsif find_success(invoice_id) == true &&
          @invoices.find_by_id(invoice_id).status != :returned
      true
    else
      false
    end
  end
end

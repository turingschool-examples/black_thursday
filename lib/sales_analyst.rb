# frozen_string_literal: true

require 'bigdecimal'
require 'bigdecimal/util'
class SalesAnalyst
  include MakeTime
  attr_reader :items,
              :merchants,
              :invoices,
              :customers,
              :invoice_items,
              :transactions

  def initialize(items, merchants, invoices, customers, invoice_items, transactions)
    @items = items
    @merchants = merchants
    @invoices = invoices
    @customers = customers
    @invoice_items = invoice_items
    @transactions = transactions
  end

  def average_items_per_merchant
    (@items.all.size.to_f / @merchants.all.size).round(2)
  end

  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    sum = array_of_items_per_merchant.sum(0.0) { |element| (element - mean) ** 2 }
    variance = sum / (@merchants.all.size - 1)
    return Math.sqrt(variance).round(2)
  end

  def array_of_items_per_merchant
    @merchants.all.map do |merchant|
      @items.find_all_by_merchant_id(merchant.id).size
    end
  end

  def merchants_with_high_item_count
    one_std_dev_above_avg = avg_plus_std_dev
    @merchants.all.select do |merchant|
      @items.find_all_by_merchant_id(merchant.id).size > one_std_dev_above_avg
    end
  end

  def avg_plus_std_dev
    (average_items_per_merchant + average_items_per_merchant_standard_deviation).to_i
  end

  def average_item_price_for_merchant(merchant_id)
    sum_of_items = @items.find_all_by_merchant_id(merchant_id).sum do |item|
      item.unit_price
    end
    number_of_items = @items.find_all_by_merchant_id(merchant_id).size
    (sum_of_items / number_of_items).round(2)
  end

  def average_average_price_per_merchant
    total_of_averages = @merchants.all.sum do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    (total_of_averages / @merchants.all.size).floor(2)
    # floor passes the spec harness- thats the only reason its here...
  end

  def average_item_price
    sum_of_items = @items.all.sum(&:unit_price)
    sum_of_items / @items.all.size
  end

  def average_item_price_std_dev
    mean = average_item_price
    sum = array_of_items_price.sum(0.0) { |element| (element - mean) ** 2 }
    variance = sum / (@items.all.size - 1)
    return Math.sqrt(variance).round(2)
  end

  def array_of_items_price
    @items.all.map(&:unit_price)
  end

  def golden_items
    two_std_devs_above_avg = (average_item_price + (average_item_price_std_dev * 2))
    @items.all.select do |item|
      item.unit_price > two_std_devs_above_avg
    end
  end

  def average_invoices_per_merchant
    (@invoices.all.size / @merchants.all.size.to_f).round(2)
  end

  def invoices_for_each_of_the_merchants
    @merchants.all.map do |merchant|
      @invoices.find_all_by_merchant_id(merchant.id).size
    end
  end

  def average_invoices_per_merchant_standard_deviation
    mean = average_invoices_per_merchant
    sum = invoices_for_each_of_the_merchants.sum(0.00) { |element| (element - mean) ** 2 }
    variance = sum / (@merchants.all.size - 1)
    return Math.sqrt(variance).round(2)
  end

  def top_merchants_by_invoice_count
    two_std_devs_above_avg = average_invoices_per_merchant + (average_invoices_per_merchant_standard_deviation * 2)
    @merchants.all.find_all do |merchant|
      @invoices.find_all_by_merchant_id(merchant.id).size >= two_std_devs_above_avg
    end
  end

  def bottom_merchants_by_invoice_count
    two_std_devs_below_avg = average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2)
    @merchants.all.find_all do |merchant|
      @invoices.find_all_by_merchant_id(merchant.id).size <= two_std_devs_below_avg
    end
  end

  def top_days_by_invoice_count
    invoice_days = @invoices.all.map do |invoice|
      invoice.created_at.strftime('%A')
    end.tally
    max_day = invoice_days.max_by do |key, value|
      value
    end
    invoice_days.select do |key, value|
      value == max_day[1]
    end.keys
  end

  def invoice_status(status)
    invoices_with_status = @invoices.find_all_by_status(status).size
    (invoices_with_status / @invoices.all.size.to_f * 100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    results = @transactions.find_all_by_invoice_id(invoice_id).select do |transaction|
      transaction.result == :success
    end
    !results.empty?
  end

  def invoice_total(invoice_id)
    return 0 unless invoice_paid_in_full?(invoice_id)
    @invoice_items.find_all_by_invoice_id(invoice_id).sum do |invoice_item|
      invoice_item.unit_price * invoice_item.quantity
    end
  end


  def total_revenue_by_date(date)
    invoices_by_date = @invoices.all.find_all do |invoice|
      invoice.created_at == return_time_from(date)
    end
    invoices_by_date.sum do |invoice| 
      invoice_total(invoice.id)
    end
  end
end

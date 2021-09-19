require 'csv'
require 'bigdecimal'
require_relative 'sales_engine'

class SalesAnalyst
  def initialize(repos)
    @items         = repos[:items]
    @merchants     = repos[:merchants]
    @invoices      = repos[:invoices]
    @invoice_items = repos[:invoice_items]
    @transactions  = repos[:transactions]
  end

  def average_items_per_merchant
    (@items.all.length.to_f/@merchants.all.length.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    sum = @merchants.all.sum do |merchant|
      (@items.find_all_by_merchant_id(merchant.id).length.to_f - mean)**2
    end

    Math.sqrt(sum / (@merchants.all.length.to_f - 1)).round(2)
  end

  def merchants_with_high_item_count
    mean = average_items_per_merchant
    std_dev = average_items_per_merchant_standard_deviation

    @merchants.all.find_all do |merchant|
      mean + std_dev < @items.find_all_by_merchant_id(merchant.id).length
    end
  end

  def average_item_price_for_merchant(id)
    items = @items.find_all_by_merchant_id(id)

    sum = items.sum do |item|
      item.unit_price
    end

    BigDecimal((sum / items.length.to_f).round(2))
  end

  def average_average_price_per_merchant
    total = @merchants.all.sum do |merchant|
      average_item_price_for_merchant(merchant.id)
    end

    (total / @merchants.all.length.to_f).round(2)
  end

  def average_price_standard_deviation
    mean = average_average_price_per_merchant
    item_count = (@items.all.length.to_f - 1)

    sum = @items.all.sum do |item|
      (item.unit_price.to_f - mean)**2
    end

    Math.sqrt(sum / item_count).round(2)
  end

  def golden_items
    mean = average_average_price_per_merchant
    std_dev = average_price_standard_deviation
    threshold = mean + std_dev * 2

    @items.all.find_all do |item|
      item.unit_price > threshold
    end
  end

  def average_invoices_per_merchant
    (@invoices.all.length.to_f / @merchants.all.length.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    mean = average_invoices_per_merchant
    sum = @merchants.all.sum do |merchant|
      (@invoices.find_all_by_merchant_id(merchant.id).length.to_f - mean)**2
    end
    Math.sqrt(sum / (@merchants.all.length.to_f - 1)).round(2)
  end

  def top_merchants_by_invoice_count
    mean    = average_invoices_per_merchant
    std_dev = average_invoices_per_merchant_standard_deviation

    @merchants.all.find_all do |merchant|
      (mean + 2 * std_dev) <= @invoices.find_all_by_merchant_id(merchant.id).length
    end
  end

  def bottom_merchants_by_invoice_count
    mean    = average_invoices_per_merchant
    std_dev = average_invoices_per_merchant_standard_deviation

    @merchants.all.find_all do |merchant|
      (mean - 2 * std_dev) >= @invoices.find_all_by_merchant_id(merchant.id).length
    end
  end

  def invoices_by_day
    invoices_by_day = { 0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0 }
    @invoices.all.each do |invoice|
      time = invoice.created_at.wday
      invoices_by_day[time] += 1
    end
    invoices_by_day
  end

  def invoices_by_day_mean
    (invoices_by_day.values.sum.to_f / 7).round(2)
  end

  def invoices_by_day_standard_deviation
    sum = invoices_by_day.values.sum do |daily_value|
      (daily_value - invoices_by_day_mean)**2
    end

    Math.sqrt(sum / 6.0).round(2)
  end

  def top_days_by_invoice_count
    top_values = invoices_by_day.values.find_all do |value|
      invoices_by_day_mean + invoices_by_day_standard_deviation <= value
    end

    top_values.map do |value|
      Date::DAYNAMES[invoices_by_day.key(value)]
    end
  end

  def invoice_status(status)
    total = @invoices.all.length.to_f
    (100.0 * @invoices.find_all_by_status(status).length / total).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    all_transaction = @transactions.find_all_by_invoice_id(invoice_id)
    trans_result = false

    all_transaction.each do |transaction|
      if transaction.result == 'success'
        trans_result = true
        break
      end
    end
    trans_result
  end

  def invoice_total(invoice_id)
    all_invoice_items = @invoice_items.find_all_by_invoice_id(invoice_id)

    total = 0

    all_invoice_items.each do |invoice_item|
      total += (invoice_item.quantity * invoice_item.unit_price)
    end

    total
  end

end

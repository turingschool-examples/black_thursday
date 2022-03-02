require_relative '../lib/mathable'
require_relative '../lib/merchants_repository'
require_relative '../lib/items_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/time_helper'
require_relative '../lib/transaction_repository'
require_relative '../lib/invoice_items_repository'
require 'pry'

class Analyst
  include Mathable
  include TimeHelper

  def initialize
    @mr = MerchantsRepository.new("./data/merchants.csv")
    @ir = ItemsRepository.new("./data/items.csv")
    @in = InvoiceRepository.new("./data/invoices.csv")
    @tr = TransactionRepository.new("./data/transactions.csv")
    @iir = InvoiceItemsRepository.new("./data/invoice_items.csv")
  end

  def average_items_per_merchant
    average(@ir.repository.count.to_f, @mr.repository.count)
  end

  def average_items_per_merchant_standard_deviation
    merchant_item_numbers = @ir.merchant_ids.values.map { |list| list.count }
    stn_dev = standard_devation(merchant_item_numbers, average_items_per_merchant)
  end

  def merchants_with_high_item_count
    big_sellers = @ir.merchant_ids.select do |merchant, items|
      items.count > (average_items_per_merchant + average_items_per_merchant_standard_deviation)
    end
  end

  def average_item_price_per_merchant(merchant_id)
    items = @ir.find_all_by_merchant_id(merchant_id)
    # binding.pry
    unit_price_array = items.map { |price| price.unit_price}
    average_price = average(unit_price_array.sum, unit_price_array.count)
    in_dollars = (average_price / 100).round(2)
  end

  def average_average_price_per_merchant
    array_of_prices = @mr.repository.map do |merchant|
      average_item_price_per_merchant(merchant.id)
    end
    average = average(array_of_prices.sum, array_of_prices.count)
    return average
  end

  def golden_items
    list = @ir.repository.map { |item| item.unit_price.to_i}
    mean = average(list.sum, list.count)
    std_dev = standard_devation(list, mean)
    golden_items = @ir.repository.select do |gi|
      gi.unit_price.to_i > (mean + (std_dev * 2))
    end
  end

  def average_invoices_per_merchant
    average(@in.repository.count.to_f, @mr.repository.count)
  end

  def average_invoices_per_merchant_standard_deviation
    merchant_invoice_list = @in.merchant_ids.map { |id, invoices| invoices.count}
    std_dev = standard_devation(merchant_invoice_list, average_invoices_per_merchant)
  end

  def top_merchants_by_invoice_count
    top_sellers = @in.merchant_ids.select do |id, list|
      list.count > (average_invoices_per_merchant + (average_items_per_merchant_standard_deviation * 2))
    end
  end

  def bottom_merchants_by_invoice_count
    bottom_sellers = @in.merchant_ids.select do |id, list|
      list.count < (average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2))
    end
  end

  def top_days_by_invoice_count
    invoices_per_day = @in.call_weekdays.map { |day, invoices| invoices.count}
    mean = average(invoices_per_day.sum.to_f, invoices_per_day.count)
    std_dev = standard_devation(invoices_per_day, mean)
    top_days = @in.call_weekdays.select do |day, invoices|
      invoices.count > (mean + std_dev)
    end
    top_days.keys
  end

  def invoice_status(status)
    decimal = (@in.invoice_status[status].count.to_f / @in.repository.count)
    percentage = (decimal * 100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    transactions = @tr.find_all_by_invoice_id(invoice_id)
    return false if transactions.nil?
    if transactions.map {|transaction| transaction.result }.include?("success")
      true
    else
     false
    end
  end

  def invoice_total(invoice_id)
    invoice_items = @iir.find_all_by_invoice_id(invoice_id.to_s)
    sum = 0
    invoice_items.each { |invoice_item| sum += ((invoice_item.unit_price.to_f * invoice_item.quantity.to_f)/100.0) }
    sum
  end

  def merchant_with_pending_invoices
  coolio = @in.invoice_status[:pending].find_all do |invoice|
            invoice_paid_in_full?(invoice.id) == false
          end
  yeah = coolio.map do |invoice|
    invoice.merchant_id
  end
  array = []
  yeah.each do |merchant_id|
    array << @mr.find_by_id(merchant_id)
  end
  array.uniq
  end
end

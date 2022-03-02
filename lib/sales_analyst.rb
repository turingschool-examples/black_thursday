# frozen_string_literal: true

require 'bigdecimal'
require 'bigdecimal/util'
require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :items, :merchants, :invoices, :transactions, :customers, :invoice_items

  def initialize(items, merchants, invoices, transactions, _customers, invoice_items)
    @items = items
    @merchants = merchants
    @invoices = invoices
    @transactions = transactions
    @invoice_items = invoice_items
  end

  def average_items_per_merchant
    (@items.all.count.to_f / @merchants.all.count).round(2)
  end

  def total_items_per_merchant
    @items_per_merchant = {}
    @items.all.each do |item|
      @items_per_merchant[item.merchant_id] = 0 unless @items_per_merchant.key?(item.merchant_id)
      !@items_per_merchant[item.merchant_id] += 1
    end
    @items_per_merchant
  end

  def average_items_per_merchant_standard_deviation
    total_items_per_merchant
    total_square_diff = 0
    total_items_per_merchant.values.map do |item_count|
      total_square_diff += ((item_count - average_items_per_merchant)**2)
    end
    Math.sqrt(total_square_diff / (@merchants.all.count - 1)).round(2)
  end

  def merchants_with_high_item_count
    @high_item_merchants = []
    total_items_per_merchant.select { |_k, v| v > 6 }.each_key do |high_id|
      @merchants.all.each do |merchant|
        @high_item_merchants << merchant if merchant.id == high_id
      end
    end
    @high_item_merchants
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_items = @items.all.find_all { |item| item.merchant_id == merchant_id }
    total_price = BigDecimal(0)
    merchant_items.map do |item|
      total_price += item.unit_price_to_dollars
    end
    BigDecimal((total_price / total_items_per_merchant[merchant_id]).to_f.round(2), 4)
  end

  def average_average_price_per_merchant
    sum_of_averages = BigDecimal(0)
    @merchants.all.map do |merchant|
      sum_of_averages += average_item_price_for_merchant(merchant.id)
    end
    BigDecimal((sum_of_averages / @merchants.all.count), 5).truncate(2)
  end

  def golden_items
    average = average_average_price_per_merchant
    total_square_diff = 0
    @items.all.each do |item|
      total_square_diff += ((item.unit_price.to_i - average)**2)
    end
    std_dev = Math.sqrt(total_square_diff / (@items.all.count - 1))
    @items.all.find_all { |item| item.unit_price.to_i > (average + (std_dev * 2)) }
  end

  def average_invoices_per_merchant
    (@invoices.all.count.to_f / @merchants.all.count).round(2)
  end

  def total_invoices_per_merchant
    @invoices_per_merchant = {}
    @invoices.all.each do |item|
      @invoices_per_merchant[item.merchant_id] = 0 unless @invoices_per_merchant.key?(item.merchant_id)
      !@invoices_per_merchant[item.merchant_id] += 1
    end
    @invoices_per_merchant
  end

  def average_invoices_per_merchant_standard_deviation
    total_invoices_per_merchant
    total_square_diff = 0
    total_invoices_per_merchant.values.map do |item_count|
      total_square_diff += ((item_count - average_invoices_per_merchant)**2)
    end
    Math.sqrt(total_square_diff / (@merchants.all.count - 1)).round(2)
  end

  def top_merchants_by_invoice_count
    @high_invoice_merchants = []
    total_invoices_per_merchant.select do |_k, v|
      v > (average_invoices_per_merchant + (average_invoices_per_merchant_standard_deviation * 2))
    end.each_key do |high_id|
      @merchants.all.each do |merchant|
        @high_invoice_merchants << merchant if merchant.id == high_id
      end
    end
    @high_invoice_merchants
  end

  def bottom_merchants_by_invoice_count
    @low_invoice_merchants = []
    total_invoices_per_merchant.select do |_k, v|
      v < (average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2))
    end.each_key do |high_id|
      @merchants.all.each do |merchant|
        @low_invoice_merchants << merchant if merchant.id == high_id
      end
    end
    @low_invoice_merchants
  end

  def invoices_by_day_of_week
    invoices_by_day_of_week = {}
    @invoices.all.each do |invoice|
      unless invoices_by_day_of_week.key?(invoice.created_at.strftime('%A'))
        invoices_by_day_of_week[invoice.created_at.strftime('%A')] =
          0
      end
      !invoices_by_day_of_week[invoice.created_at.strftime('%A')] += 1
    end
    invoices_by_day_of_week
  end

  def std_dev_of_invoices_per_day
    average_invoice_per_day = (@invoices.all.count / 7).to_f
    total_square_diff = 0
    invoices_by_day_of_week.each do |_day, count|
      total_square_diff += ((count - average_invoice_per_day)**2)
    end
    Math.sqrt(total_square_diff.to_f / 6).round(2)
  end

  def top_days_by_invoice_count
    average_invoice_per_day = (@invoices.all.count / 7).to_f
    top_days = invoices_by_day_of_week.find_all do |_day, count|
      count > (average_invoice_per_day + std_dev_of_invoices_per_day)
    end
    top_days.flatten.find_all { |item| item.instance_of?(String) }
  end

  def invoice_status(status_type)
    invoice_type_count = Hash.new(0)
    @invoices.all.each do |invoice|
      invoice_type_count[invoice.status.to_sym] += 1
    end
    ((invoice_type_count[status_type].to_f / @invoices.all.count) * 100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    transactions_by_invoice = @transactions.find_all_by_invoice_id(invoice_id)
    transactions_by_invoice.any? { |transaction| transaction.result == :success }
  end

  def invoice_total(invoice_id)
    invoices = @invoice_items.find_all_by_invoice_id(invoice_id) if invoice_paid_in_full?(invoice_id) == true
    invoices.map { |invoice| (invoice.unit_price * invoice.quantity) }.sum
  end

  def total_revenue_by_date(date)
    invoice_id_by_date = []
    @invoices.all.each do |invoice|
      invoice_id_by_date << invoice.id if invoice.created_at.strftime("%D") == date.strftime("%D")
    end
    invoice_items_by_date = []
    invoice_id_by_date.each do |invoice_id|
      invoice_items_by_date << @invoice_items.find_all_by_invoice_id(invoice_id)
    end
    invoice_items_by_date.flatten.map { |invoice| (invoice.unit_price * invoice.quantity) }.sum
  end
end

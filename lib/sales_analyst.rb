require 'bigdecimal'
require 'bigdecimal/util'
require_relative 'sales_engine'
require_relative 'item_repository'

class SalesAnalyst
  attr_reader :items, :merchants, :invoices, :transactions

  def initialize(items, merchants, invoices, transactions)
    @items = items
    @merchants = merchants
    @invoices = invoices
    @transactions = transactions
    @items_per_merchant = {}
  end

  def average_items_per_merchant
    (@items.count.to_f / @merchants.count).round(2)
  end

  def total_items_per_merchant
    @items_per_merchant = {}
    @items.each do |item|
      @items_per_merchant[item.merchant_id] = 0 unless @items_per_merchant.has_key?(item.merchant_id)
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
    Math.sqrt(total_square_diff / (@merchants.count - 1)).round(2)
  end

  def merchants_with_high_item_count
    @high_item_merchants = []
    total_items_per_merchant.select { |_k, v| v > 6 }.keys.each do |high_id|
      @merchants.each do |merchant|
        @high_item_merchants << merchant if merchant.id == high_id
      end
    end
    @high_item_merchants
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_items = @items.find_all { |item| item.merchant_id == merchant_id }
    total_price = BigDecimal(0)
    merchant_items.map do |item|
      total_price += item.unit_price_to_dollars
    end
    BigDecimal((total_price / total_items_per_merchant[merchant_id]).to_f.round(2), 4)
  end

  def average_average_price_per_merchant
    sum_of_averages = BigDecimal(0)
    @merchants.map do |merchant|
      sum_of_averages += average_item_price_for_merchant(merchant.id)
    end
    BigDecimal((sum_of_averages / @merchants.count), 5).truncate(2)
  end

  def golden_items
    average = average_average_price_per_merchant
    total_square_diff = 0
    @items.each do |item|
      total_square_diff += ((item.unit_price.to_i - average)**2)
    end
    std_dev = Math.sqrt(total_square_diff / (@items.count - 1))
    @items.find_all { |item| item.unit_price.to_i > (average + (std_dev * 2)) }
  end

  def average_invoices_per_merchant
    (@invoices.count.to_f / @merchants.count).round(2)
  end

  def total_invoices_per_merchant
    @invoices_per_merchant = {}
    @invoices.each do |item|
      @invoices_per_merchant[item.merchant_id] = 0 unless @invoices_per_merchant.has_key?(item.merchant_id)
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
    Math.sqrt(total_square_diff / (@merchants.count - 1)).round(2)
  end

  def top_merchants_by_invoice_count
    @high_invoice_merchants = []
    total_invoices_per_merchant.select do |_k, v|
      v > (average_invoices_per_merchant + (average_invoices_per_merchant_standard_deviation * 2))
    end.keys.each do |high_id|
      @merchants.each do |merchant|
        @high_invoice_merchants << merchant if merchant.id == high_id
      end
    end
    @high_invoice_merchants
  end

  def bottom_merchants_by_invoice_count
    @low_invoice_merchants = []
    total_invoices_per_merchant.select do |_k, v|
      v < (average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2))
    end.keys.each do |high_id|
      @merchants.each do |merchant|
        @low_invoice_merchants << merchant if merchant.id == high_id
      end
    end
    @low_invoice_merchants
  end

  def invoices_by_day_of_week
    invoices_by_day_of_week = {}
    @invoices.each do |invoice|
      unless invoices_by_day_of_week.has_key?(invoice.created_at.strftime('%A'))
        invoices_by_day_of_week[invoice.created_at.strftime('%A')] =
          0
      end
      !invoices_by_day_of_week[invoice.created_at.strftime('%A')] += 1
    end
    invoices_by_day_of_week
  end

  def std_dev_of_invoices_per_day
    average_invoice_per_day = (@invoices.count / 7).to_f
    total_square_diff = 0
    invoices_by_day_of_week.each do |_day, count|
      total_square_diff += ((count - average_invoice_per_day)**2)
    end
    Math.sqrt(total_square_diff.to_f / 6).round(2)
  end

  def top_days_by_invoice_count
    average_invoice_per_day = (@invoices.count / 7).to_f
    top_days = invoices_by_day_of_week.find_all do |_day, count|
      count > (average_invoice_per_day + std_dev_of_invoices_per_day)
    end
    top_days.flatten.find_all { |item| item.instance_of?(String) }
  end

  def invoice_status(status_type)
    invoice_type_count = Hash.new(0)
    @invoices.each do |invoice|
      invoice_type_count[invoice.status.to_sym] += 1
    end
    ((invoice_type_count[status_type].to_f / @invoices.count) * 100).round(2)
  end
end

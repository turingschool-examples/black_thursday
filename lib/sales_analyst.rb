# frozen_string_literal: true

require 'bigdecimal'
require 'pry'

# Sales anaylst class
class SalesAnalyst
  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    merchant_count = all_merchants.size.to_f
    item_count = all_items.size.to_f
    BigDecimal((item_count / merchant_count), 3).to_f
  end

  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant

    items_per_merchant = all_merchants.map do |merchant|
      @engine.items.find_all_by_merchant_id(merchant.id).size
    end

    standard_deviation(items_per_merchant, mean)
  end

  def merchants_with_high_item_count
    threshold = average_items_per_merchant + average_items_per_merchant_standard_deviation

    all_merchants.find_all do |merchant|
      @engine.items.find_all_by_merchant_id(merchant.id).size > threshold
    end
  end

  def average_item_price_for_merchant(merchant_id)
    total_items = @engine.items.find_all_by_merchant_id(merchant_id).size
    all_items_merchant = @engine.items.find_all_by_merchant_id(merchant_id)
    total_sum = all_items_merchant.inject(0) do |sum, item|
      sum + item.unit_price
    end
    average_price = total_sum / total_items
    BigDecimal(average_price, 5).round(2)
  end

  def average_average_price_per_merchant
    average_price_array = all_merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    average_price_sum = average_price_array.inject(0) do |sum, price|
      sum + price
    end
    total_average = (average_price_sum / average_price_array.size).round(2)
    BigDecimal(total_average, 5)
  end

  def golden_items
    mean = all_prices_sum / all_items.size
    std = standard_deviation(all_prices, mean)
    golden_threshold = mean + std * 2

    all_items.find_all do |item|
      item.unit_price > golden_threshold
    end
  end

  def average_invoices_per_merchant
    total_invoices = all_invoices.size.to_f
    total_merchants = all_merchants.size.to_f
    (total_invoices / total_merchants).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    mean = average_invoices_per_merchant
    standard_deviation(invoices_per_merchant, mean)
  end

  def top_merchants_by_invoice_count
    mean = average_invoices_per_merchant
    two_std = average_invoices_per_merchant_standard_deviation * 2

    all_merchants.find_all do |merchant|
      @engine.invoices.find_all_by_merchant_id(merchant.id).size > (two_std + mean)
    end
  end

  def bottom_merchants_by_invoice_count
    mean = average_invoices_per_merchant
    two_std = average_invoices_per_merchant_standard_deviation * 2

    all_merchants.find_all do |merchant|
      @engine.invoices.find_all_by_merchant_id(merchant.id).size < (mean - two_std)
    end
  end

  def top_days_by_invoice_count
    mean = all_invoices.size.to_f / count_invoices_per_day.size
    threshold = mean + standard_deviation(count_invoices_per_day, mean)

    top_days = invoices_by_day.find_all do |_, object_array|
      object_array.size > threshold
    end

    remove_keys(top_days, Invoice)
  end

  def invoice_status(status)
    invoices_by_status = all_invoices.count do |invoice|
      invoice.status == status
    end
    ((invoices_by_status.to_f / all_invoices.size) * 100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    transactions = @engine.transactions.find_all_by_invoice_id(invoice_id)
    transactions.any? do |transaction|
      transaction.result == :success
    end
  end

  def invoice_total(invoice_id)
    invoice_items = @engine.invoice_items.find_all_by_invoice_id(invoice_id)
    total = invoice_items.inject(0) do |sum, invoice_item|
      sum + invoice_item.quantity * invoice_item.unit_price_to_dollars
    end
    BigDecimal(total, total.to_s.size - 1)
  end

  def merchants_with_pending_invoices
    all_merchants.find_all do |merchant|
      invoices = @engine.invoices.find_all_by_merchant_id(merchant.id)
      invoices.any? do |invoice|
        invoice.status == :pending
      end
    end
  end

  private

  def standard_deviation(data_set, mean)
    total_sum = data_set.inject(0) do |sum, number_items|
      sum + (number_items - mean)**2
    end
    Math.sqrt(total_sum / (data_set.size - 1)).round(2).to_f
  end

  def all_items
    @engine.items.all
  end

  def all_merchants
    @engine.merchants.all
  end

  def all_invoices
    @engine.invoices.all
  end

  def all_prices
    all_items.map(&:unit_price)
  end

  def all_prices_sum
    all_prices.inject(0) do |sum, price|
      sum + price
    end
  end

  def invoices_by_day
    all_invoices.group_by do |invoice|
      invoice.created_at.strftime('%A')
    end
  end

  def remove_keys(data, type)
    data.flatten.delete_if do |element|
      element.is_a?(type)
    end
  end

  def invoices_per_merchant
    all_merchants.map do |merchant|
      @engine.invoices.find_all_by_merchant_id(merchant.id).size
    end
  end

  def count_invoices_per_day
    invoices_by_day.map do |_, invoice|
      invoice.count
    end
  end
end

require 'csv'
require 'pry'
require 'bigdecimal'
require 'time'
require_relative './sales_engine'
require_relative './standard_deviation'

class SalesAnalyst
  extend StandardDeviation

  attr_reader :engine
  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    (engine.items.all.count.to_f / engine.merchants.all.count).round(2)
  end

  def reduce_shop_items
    engine.merchants.all.reduce({}) do |memo, merchant|
      memo[merchant.id] = []
      engine.items.all.each do |item|
        if item.merchant_id == merchant.id
          memo[merchant.id] << item.unit_price
        end
      end
      memo
    end
  end

  def number_of_items
    reduce_shop_items.map{|merchant, item| item.count }
  end

  def average_items_per_merchant_standard_deviation
    numbers = number_of_items.extend(StandardDeviation)
    numbers.standard_deviation
  end

  def average_by_average_merchant_deviation
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def merchant_names_with_high_item_count
    deviation = average_by_average_merchant_deviation
    array = reduce_shop_items.map do |shop, item|
      if item.count >= deviation
        shop
      end
    end
    array.uniq[1..-1]
  end

  def merchants_with_high_item_count
    merchant_array = []
    merchant_names_with_high_item_count.each do |merchant_name|
      engine.merchants.all.each do |merchant_object|
        merchant_array << merchant_object if merchant_object.id == merchant_name
      end
    end
    merchant_array
  end

  def average_item_price_for_merchant(merchant_id)
    item_shop = reduce_shop_items.extend(StandardDeviation)
    (item_shop[merchant_id].sum / item_shop[merchant_id].count).round(2)
  end

  def average_average_price_per_merchant
    average_price = reduce_shop_items
    prices = engine.merchants.all.map do |merchant|
      (average_price[merchant.id].sum / average_price[merchant.id].count)
    end
    BigDecimal(prices.sum / average_price.keys.count).round(2)
  end

  def second_deviation_above_unit_price
    unit_price_array = reduce_shop_items.values.flatten
    unit_price_array = unit_price_array.extend(StandardDeviation)
    (average_average_price_per_merchant) + (unit_price_array.standard_deviation * 2)
  end

  def golden_items
    golden = []
    deviation = second_deviation_above_unit_price
    engine.items.all.each do |item|
      golden << item if item.unit_price > deviation
    end
    golden
  end

  def average_invoices_per_merchant
    (engine.invoices.all.count / engine.merchants.all.count.to_f).round(2)
  end

  def reduce_merchants_and_invoices
  end_hash = engine.merchants.all.reduce({}) do |memo, merchant|
      memo[merchant.id] = []
      engine.invoices.all.map do |invoice|
        if invoice.merchant_id == merchant.id
          memo[merchant.id] << invoice
        end
      end
      memo
    end
  end

  def number_of_invoices
    result = reduce_merchants_and_invoices.map{|merchant, invoice| invoice.count }
  end

  def average_invoices_per_merchant_standard_deviation
    result = number_of_invoices.extend(StandardDeviation)
    result.standard_deviation
  end

  def second_deviation_above_average_invoice_count
    invoices_per_merchant = number_of_invoices
    invoices_per_merchant = invoices_per_merchant.extend(StandardDeviation)
    ((average_invoices_per_merchant) + (invoices_per_merchant.standard_deviation * 2)).round(2)
  end

  def top_merchants_by_invoice_count
    top_merchants = []
    deviation = second_deviation_above_average_invoice_count
    merchant_hash = reduce_merchants_and_invoices
    merchant_hash.map do |merchant, array|
      if array.count > deviation
        top_merchants << engine.merchants.find_by_id(merchant)
      end
    end
    top_merchants
  end

  def second_deviation_below_average_invoice_count
    invoices_per_merchant = number_of_invoices
    invoices_per_merchant = invoices_per_merchant.extend(StandardDeviation)
    ((average_invoices_per_merchant) - (invoices_per_merchant.standard_deviation * 2)).round(2)
  end

  def bottom_merchants_by_invoice_count
    bottom_merchants = []
    deviation = second_deviation_below_average_invoice_count
    merchant_hash = reduce_merchants_and_invoices
    merchant_hash.map do |merchant, array|
      if array.count < deviation
        bottom_merchants << engine.merchants.find_by_id(merchant)
      end
    end
    bottom_merchants
  end

  def reduce_invoices_and_days
   final_hash = engine.invoices.all.group_by{|invoice| invoice.created_at.strftime("%A")}
  end

  def invoices_by_day_count
    reduce_invoices_and_days.map{|invoice, day| day.count}
  end

  def average_invoices_per_day_standard_deviation
    result = invoices_by_day_count.extend(StandardDeviation)
    result.standard_deviation
  end

  def average_invoices_per_day
    result = invoices_by_day_count.extend(StandardDeviation)
    result.item_mean.round(2)
  end

  def one_deviation_above_invoices_per_day
    work  = invoices_by_day_count.extend(StandardDeviation)
    work.standard_deviation + average_invoices_per_day
  end

  def top_days_by_invoice_count
    result = []
    deviation = one_deviation_above_invoices_per_day
    reduce_invoices_and_days.map do |day, invoices|
      if invoices.count > deviation
       result << invoices[0].created_at.strftime("%A")
      end
    end
    result
  end

  def invoice_status(status)
    total_status = engine.invoices.all.find_all{|invoice| invoice.status == status}.count
    ((total_status.to_f / engine.invoices.all.count) * 100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    all_transactions = engine.transactions.all

    transactions = all_transactions.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
    if transactions == []
      return false
    else
      transactions.any? { |transaction| transaction.result == :success}
    end
  end

  def invoice_total(invoice_id)
    all_invoice_items = engine.invoice_items.all

    invoices_items = all_invoice_items.find_all do |item|
      item.invoice_id == invoice_id
    end

    items_total = invoices_items.map do |item|
      item.quantity * item.unit_price
    end

    BigDecimal(items_total.sum).round(2)
  end

  def total_revenue_by_date(date)
    invoices_by_date = engine.invoices.all.find_all do |invoice|
      invoice.created_at.strftime("%d/%m/%Y") == date.strftime("%d/%m/%Y")
    end
    revenue = invoices_by_date.map do  |invoice|
      invoice_total(invoice.id) if invoice_paid_in_full?(invoice.id)
    end
    revenue.compact.sum
  end
end

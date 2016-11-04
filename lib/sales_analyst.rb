require_relative 'sales_engine'
require_relative 'standard_deviation'
require 'pry'

class SalesAnalyst
  include StandardDeviation
  attr_reader   :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def total_items
    sales_engine.items.all.count
  end

  def total_merchants
    sales_engine.merchants.all.count
  end

  def total_invoices
    sales_engine.invoices.all.count
  end

  def average_items_per_merchant
    (total_items.to_f / total_merchants.to_f).round(2)
  end

  def average_invoices_per_merchant
    (total_invoices.to_f / total_merchants.to_f).round(2)
  end

  def collect_items_per_merchant
    sales_engine.merchants.all.map do |merchant|
      merchant.items.length
    end
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(collect_items_per_merchant).round(2)
  end

  def collect_invoices_per_merchant
    sales_engine.merchants.all.map do |merchant|
      merchant.invoices.length
    end
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(collect_invoices_per_merchant).round(2)
  end

  def items_given_merchant_id(merchant_id)
    merchant = sales_engine.find_merchant(merchant_id)
    merchant.items
  end

  def average_item_price_for_merchant(merchant_id)
    items = items_given_merchant_id(merchant_id)
    sum_of_prices = items.reduce(0) do |sum, item|
      sum += item.unit_price
    end
    (sum_of_prices / items.count).round(2)
  end

  def average_average_price_per_merchant
    all_merchants = sales_engine.merchants.all
    sum_of_averages = all_merchants.reduce(0) do |total, merchant|
      total += average_item_price_for_merchant(merchant.id)
      total
    end
    (sum_of_averages / total_merchants).round(2)
  end

  def get_all_prices
    prices = sales_engine.items.all.map do |item|
      item.unit_price
    end
  end

  def golden_prices
    above_standard_deviation(get_all_prices, 2)
  end

  def golden_items
    items = golden_prices.map do |price|
      sales_engine.items.find_all_by_price(price)
    end
    items.flatten.uniq
  end

  def number_of_items_for_every_merchant
    sales_engine.merchants.all.map do |merchant|
      merchant.items.length
    end
  end

  def merchants_with_high_item_count
    item_count = number_of_items_for_every_merchant
    cut = mean(item_count) + standard_deviation(item_count)
    sales_engine.merchants.all.find_all do |merchant|
      merchant.items.count > cut
    end
  end

  def top_merchants_by_invoice_count
    invoice_count = collect_invoices_per_merchant
    cut = mean(invoice_count) + 2 * standard_deviation(invoice_count)
    sales_engine.merchants.all.find_all do |merchant|
      merchant.invoices.count > cut
    end
  end

  def bottom_merchants_by_invoice_count
    invoice_count = collect_invoices_per_merchant
    cut = mean(invoice_count) - 2 * standard_deviation(invoice_count)
    sales_engine.merchants.all.find_all do |merchant|
      merchant.invoices.count < cut
      end
  end

  def find_invoice_status
  sales_engine.invoices.all.each_with_object(Hash.new(0)) do |invoice,counts|
    counts[invoice.status] += 1
    end
  end

  def invoice_status(status)
    ((find_invoice_status[status].to_f/ total_invoices.to_f) * 100).round(2)
  end

end

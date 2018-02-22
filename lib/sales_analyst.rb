require 'bigdecimal'
require 'pry'

# class for analytics on merchants and item prices
class SalesAnalyst
  attr_reader :sales_engine
  def initialize(se)
    @sales_engine = se
    @std_dev_price = average_items_price_standard_deviation
    @std_dev_invoice = average_invoices_per_merchant_standard_deviation
  end

  def merchants
    @sales_engine.merchants.all
  end

  def items
    @sales_engine.items.all
  end

  def invoices
    @sales_engine.invoices.all
  end

  def average(numerator, denominator)
    (BigDecimal(numerator, 4) / BigDecimal(denominator, 4)).round(2)
  end

  def standard_deviation(data, average)
    result = data.map do |item|
      (item - average)**2
    end.reduce(:+) / (data.length - 1)
    Math.sqrt(result)
  end

  def average_items_per_merchant
    average(items.length, merchants.length).to_f
  end

  def average_items_per_merchant_standard_deviation
    total_items = merchants.map { |merchant| merchant.items.length }
    standard_deviation(total_items, average_items_per_merchant).round(2)
  end

  def merchants_with_high_item_count
    merchants.collect do |merchant|
      difference = (merchant.items.length - average_items_per_merchant)
      merchant if difference > average_items_per_merchant_standard_deviation
    end.compact
  end

  def average_item_price_for_merchant(id)
    return 0 if find_items_with_merchant_id(id).length.zero?
    items = @sales_engine.pass_id_to_item_repo(id)
    prices = items.map(&:unit_price)
    average(prices.reduce(:+), items.length)
  end

  def find_items_with_merchant_id(id)
    @sales_engine.merchants.find_by_id(id).items
  end

  def average_average_price_per_merchant
    result = merchants.reduce(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id)
    end
    average(result, merchants.length)
  end

  def all_item_prices
    items.map(&:unit_price)
  end

  def average_items_price_standard_deviation
    standard_deviation(all_item_prices, average_average_price_per_merchant)
  end

  def golden_items
    result = @sales_engine.items.all.collect do |item|
      difference = (item.unit_price - average_average_price_per_merchant).to_f
      item if difference > @std_dev_price * 2
    end.compact
  end

  def average_invoices_per_merchant
    average(invoices.length, merchants.length).to_f
  end

  def average_invoices_per_merchant_standard_deviation
    total_invoices = merchants.map { |merchant| merchant.invoices.length }
    standard_deviation(total_invoices, average_invoices_per_merchant).round(2)
  end

  def top_merchants_by_invoice_count
    @sales_engine.merchants.all.collect do |merchant|
      difference = (merchant.invoices.length - average_invoices_per_merchant).to_f
      merchant if difference.abs > @std_dev_invoice * 2 && merchant.invoices.length > average_invoices_per_merchant
    end.compact
  end

  def bottom_merchants_by_invoice_count
    @sales_engine.merchants.all.collect do |merchant|
      difference = (merchant.invoices.length - average_invoices_per_merchant).to_f
      merchant if difference.abs > @std_dev_invoice * 2 && merchant.invoices.length < average_invoices_per_merchant
    end.compact
  end
end

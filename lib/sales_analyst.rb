# SalesAnalyst
require_relative 'sales_engine'
class SalesAnalyst

  attr_reader :merchant_repo,
              :item_repo

  def initialize(sales_engine)
    @merchant_repo = sales_engine.merchants
    @item_repo = sales_engine.items
    @invoice_repo = sales_engine.invoices
  end

  def average_items_per_merchant
    (item_repo.items.count.to_f / merchant_repo.merchants.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    numbers_of_item = merchant_repo.merchants.map do |merchant|
      merchant.items.count
    end
    a = numbers_of_item.reduce(0) do |sum, number|
      sum + (number - average_items_per_merchant) ** 2
    end / (numbers_of_item.count - 1)
    Math.sqrt(a).round(2)
  end

  def merchants_with_high_item_count
    one_standard_deviation = average_items_per_merchant + average_items_per_merchant_standard_deviation
    merchant_repo.merchants.map do |merchant|
      merchant if merchant.items.count > one_standard_deviation
    end.compact
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = @merchant_repo.find_by_id(merchant_id)
    merchant.items.reduce(0) do |sum, item|
      sum + item.unit_price / merchant.items.length
    end.round(2)
  end

  def average_average_price_per_merchant
    @merchant_repo.merchants.reduce(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id) / @merchant_repo.merchants.count
    end.round(2)
  end

  def average_price_of_items
    @item_repo.items.reduce(0) do|total, item|
      total + item.unit_price / @item_repo.items.count
    end.round(2)
  end

  def standard_deviation_for_item_price
    average_price = average_price_of_items
    a = @item_repo.items.reduce(0) do |sum , item|
      sum + (item.unit_price - average_price) ** 2
    end / (@item_repo.items.count - 1)
    Math.sqrt(a).round(2)
  end

  def golden_items
    two_standard_deviation = (average_price_of_items + standard_deviation_for_item_price) * 2
    @item_repo.items.map do |item|
      item if item.unit_price > two_standard_deviation
    end.compact
  end

  def average_invoices_per_merchant
    numbers_of_invoices = @invoice_repo.invoices.count
    numbers_of_merchants = @invoice_repo.invoices.map do |invoice|
      invoice.merchant_id
    end.uniq.count
    (numbers_of_invoices.to_f / numbers_of_merchants).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    a = average_invoices_per_merchant
    numbers_of_merchants = @merchant_repo.merchants.count
    a = @merchant_repo.merchants.reduce(0) do |sum, merchant|
      sum + (merchant.invoices.count - a) ** 2
    end / (numbers_of_merchants - 1)
    Math.sqrt(a).round(2)
  end

  def top_merchants_by_invoice_count
    two_standard_deviation = (average_invoices_per_merchant + average_invoices_per_merchant_standard_deviation) * 2
    @merchant_repo.merchants.map do |merchant|
      merchant if merchant.invoices.count > two_standard_deviation
    end.compact
  end
end

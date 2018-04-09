# frozen_string_literal: true

class SalesAnalyst
  attr_reader :sales_engine
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    all_items = list_of_number_of_items_per_merchant
    (all_items.inject(:+).to_f / @sales_engine.merchants.all.length).round(2)
  end

  def average_items_per_merchant_standard_deviation
    all_items = list_of_number_of_items_per_merchant
    average_items = average_items_per_merchant
    squared_num_items = all_items.map do |num_of_items|
      (num_of_items - average_items)**2
    end
    math = squared_num_items.inject(:+) / (all_items.length - 1)
    Math.sqrt(math).round(2)
  end

  def list_of_number_of_items_per_merchant
    @sales_engine.merchants.all.map do |merchant|
      @sales_engine.merchants.find_by_id(merchant.id).items.length
    end
  end

  def standard_deviation_of_item_price
    average_price = average_average_price_per_merchant
    list_of_prices = @sales_engine.items.all.map(&:unit_price)
    squared_num_items = list_of_prices.map do |price|
      (price.to_f - average_price.to_f)**2
    end
    Math.sqrt(squared_num_items.inject(:+) / (list_of_prices.length - 1))
  end

  def golden_items
    std_dev = standard_deviation_of_item_price
    average = average_average_price_per_merchant
    price_of_item = average + (2 * std_dev)
    price_range = price_of_item.to_i..find_max_price
    @sales_engine.items.find_all_by_price_in_range(price_range)
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = @sales_engine.merchants.find_by_id(merchant_id)
    all_items = merchant.items.map(&:unit_price)
    (all_items.inject(:+) / all_items.length).round(2)
  end

  def merchants_with_high_item_count
    std_dev = average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    amount_of_items = average + std_dev
    @sales_engine.merchants.all.map do |merchant|
      amount = @sales_engine.merchants.find_by_id(merchant.id).items.length
      merchant if amount > amount_of_items
    end.compact
  end

  def average_average_price_per_merchant
    average_prices = average_prices_over_all_merchants
    (average_prices.inject(:+) / @sales_engine.merchants.all.length).round(2)
  end

  def average_prices_over_all_merchants
    @sales_engine.merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
  end

  def find_max_price
    @sales_engine.items.all.map(&:unit_price).max.to_i
  end

  def average_invoices_per_merchant
    all_invoices = total_number_of_invoices_for_all_merchants
    (all_invoices.inject(:+).to_f / @sales_engine.merchants.all.length).round(2)
  end

  def total_number_of_invoices_for_all_merchants
    @sales_engine.merchants.all.map do |merchant|
      @sales_engine.merchants.find_by_id(merchant.id).invoices.length
    end
  end

  def average_invoices_per_merchant_standard_deviation
    average_num_of_invoices = average_invoices_per_merchant
    list_of_invoices = total_number_of_invoices_for_all_merchants
    squared_num_items = list_of_invoices.map do |invoices|
      (invoices.to_f - average_num_of_invoices.to_f)**2
    end
    calculation = squared_num_items.inject(:+) / (list_of_invoices.length - 1)
    Math.sqrt(calculation).round(2)
  end

  def top_merchants_by_invoice_count
  end

  def bottom_merchants_by_invoice_count
  end

  def top_days_by_invoice_count
  end

  def invoice_status(status)
  end
end

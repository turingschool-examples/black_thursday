# frozen_string_literal: true

require 'bigdecimal'
require 'bigdecimal/util'
require 'pry'


class SalesAnalyst
  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    merchant_count = @engine.merchants.all.size.to_f
    item_count = @engine.items.all.size.to_f
    BigDecimal((item_count / merchant_count), 3).to_f
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    all_merchants = @engine.merchants.all

    items_per_merchant = []
    all_merchants.each do |merchant|
      items_per_merchant << @engine.items.find_all_by_merchant_id(merchant.id).size
    end
    equation = items_per_merchant.inject(0) do |sum, number_items|
      sum + (number_items - average)**2
    end
    ((Math.sqrt(equation / (items_per_merchant.size - 1)).round(2))).to_f
  end

  def merchants_with_high_item_count
    std = average_items_per_merchant + average_items_per_merchant_standard_deviation
    all_merchants = @engine.merchants.all

    all_merchants.find_all do |merchant|
      @engine.items.find_all_by_merchant_id(merchant.id).size > std
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = @engine.merchants.find_by_id(merchant_id)
    total_items = @engine.items.find_all_by_merchant_id(merchant_id).size
    all_items = @engine.items.find_all_by_merchant_id(merchant_id)
    sum = all_items.inject(0) do |sum, item|
      sum + item.unit_price
    end
    average_price = sum / total_items
    BigDecimal(average_price, 5).round(2)
  end

  def average_average_price_per_merchant
    merchants = @engine.merchants.all
    average_price_array = merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    average_price_sum = average_price_array.inject(0) do |sum, price|
      sum + price
    end
    total_average = (average_price_sum / average_price_array.size).round(2)
    BigDecimal(total_average, 5)
  end

  def golden_items
    all_items = @engine.items.all
    prices_sum = all_items.inject(0) do |sum, item|
      sum + item.unit_price
    end
    average = prices_sum / all_items.size
    equation = all_items.inject(0) do |sum, item|
      sum + (item.unit_price - average)**2
    end
    std = Math.sqrt((equation / (all_items.size - 1)))
    golden_threshold = average + std*2

    result = all_items.find_all do |item|
      item.unit_price > golden_threshold
    end
  end

  def average_invoices_per_merchant
    total_invoices = @engine.invoices.all.size.to_f
    total_merchants = @engine.merchants.all.size.to_f
    (total_invoices / total_merchants).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    mean = average_invoices_per_merchant
    all_merchants = @engine.merchants.all
    invoices_per_merchant = []
    all_merchants.each do |merchant|
      invoices_per_merchant << @engine.invoices.find_all_by_merchant_id(merchant.id).size
    end
    equation = invoices_per_merchant.inject(0) do |sum, number_invoices|
      sum + (number_invoices - mean)**2
    end
    ((Math.sqrt(equation / (invoices_per_merchant.size - 1)).round(2))).to_f
  end

  def top_merchants_by_invoice_count
    mean = average_invoices_per_merchant
    two_std = average_invoices_per_merchant_standard_deviation * 2
    all_merchants = @engine.merchants.all

    all_merchants.find_all do |merchant|
      @engine.invoices.find_all_by_merchant_id(merchant.id).size > (two_std + mean)
    end
  end

end

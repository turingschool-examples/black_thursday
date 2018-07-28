# frozen_string_literal: true

require 'bigdecimal'

# Sales anaylst class
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
    mean = average_items_per_merchant
    all_merchants = @engine.merchants.all

    items_per_merchant = all_merchants.map do |merchant|
      @engine.items.find_all_by_merchant_id(merchant.id).size
    end

    standard_deviation(items_per_merchant, mean)
  end

  def merchants_with_high_item_count
    threshold = average_items_per_merchant + average_items_per_merchant_standard_deviation
    all_merchants = @engine.merchants.all

    all_merchants.find_all do |merchant|
      @engine.items.find_all_by_merchant_id(merchant.id).size > threshold
    end
  end

  def average_item_price_for_merchant(merchant_id)
    total_items = @engine.items.find_all_by_merchant_id(merchant_id).size
    all_items = @engine.items.find_all_by_merchant_id(merchant_id)
    total_sum = all_items.inject(0) do |sum, item|
      sum + item.unit_price
    end
    average_price = total_sum / total_items
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
    mean = all_prices_sum / all_items.size
    std = standard_deviation(all_prices, mean)
    golden_threshold = mean + std * 2

    all_items.find_all do |item|
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
    # invoices_per_merchant = []
    invoices_per_merchant = all_merchants.map do |merchant|
      @engine.invoices.find_all_by_merchant_id(merchant.id).size
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

  def bottom_merchants_by_invoice_count
    mean = average_invoices_per_merchant
    two_std = average_invoices_per_merchant_standard_deviation * 2
    all_merchants = @engine.merchants.all

    all_merchants.find_all do |merchant|
      @engine.invoices.find_all_by_merchant_id(merchant.id).size < (mean - two_std)
    end
  end

  def top_days_by_invoice_count
    all_invoices = @engine.invoices.all
    invoices_per_day = all_invoices.group_by do |invoice|
      invoice.created_at.strftime("%A")
    end
    count_per_day = invoices_per_day.map do |day, invoice|
      invoice.count
    end
    total_invoices = count_per_day.inject(0) do |sum, count|
      sum += count
    end
    mean = total_invoices.to_f / count_per_day.size

    std_sum = count_per_day.inject(0) do |sum, count|
      sum + (count - mean)**2
    end
    std = Math.sqrt(std_sum.to_f / 6)
    threshold = mean + std

    top_days = invoices_per_day.find_all do |day, object_array|
      object_array.size > threshold
    end
    top_days.flatten.delete_if do |element|
      element.is_a?(Invoice)
    end
  end

  def invoice_status(status)
    total_invoices = @engine.invoices.all
    invoices_by_status = total_invoices.count do |invoice|
      invoice.status == status
    end
    ((invoices_by_status.to_f / total_invoices.size) * 100).round(2)
  end

  private

  def standard_deviation(data, mean)
    total_sum = data.inject(0) do |sum, number_items|
      sum + (number_items - mean)**2
    end
    Math.sqrt(total_sum / (data.size - 1)).round(2).to_f
  end

  def all_items
    @engine.items.all
  end

  def all_prices
    all_items.map(&:unit_price)
  end

  def all_prices_sum
    all_items.inject(0) do |sum, item|
      sum + item.unit_price
    end
  end
end

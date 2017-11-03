require 'bigdecimal'
require_relative './sales_engine'

class SalesAnalyst
  attr_reader :se,
              :invoice_count,
              :merchant_count,
              :item_count

  def initialize(sales_engine)
    @se = sales_engine
    @invoice_count = se.invoices.invoices.count
    @merchant_count = se.merchants.merchants.count
    @item_count = se.items.items.count
  end

  def average_items_per_merchant
    (item_count.to_f / merchant_count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    average_items = average_items_per_merchant
    Math.sqrt(count_all_items_for_each_merchant.map do |item_count|
      (average_items - item_count) ** 2
    end.sum / (merchant_count - 1)).round(2)
  end

  def count_all_items_for_each_merchant
    se.merchants.merchants.map do |merchant|
      merchant.items.count
    end
  end

  def merchants_with_high_item_count
    minimum = minimum_for_high_items
    se.merchants.merchants.reduce([]) do |result, merchant|
      if merchant.items.count >= minimum
        result << merchant
      end
      result
    end
  end

  def minimum_for_high_items
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = se.merchants.find_by_id(merchant_id.to_s)
    return 0 if merchant.items.count.zero?
    BigDecimal((merchant.items.inject(0) do |sum, item|
      sum += item.unit_price
    end/merchant.items.count)).round(2)
  end

  def average_average_price_per_merchant
    BigDecimal((se.merchants.merchants.inject(0) do |sum, merchant|
      sum += average_item_price_for_merchant(merchant.id)
    end/merchant_count)).round(2)
  end

  def standard_deviation_of_item_price
    average_price = average_item_price
    Math.sqrt(se.items.items.map do |item|
      (average_price - item.unit_price) ** 2
    end.sum / (item_count - 1)).round(2)
  end

  def average_item_price
    BigDecimal((se.items.items.inject(0) do |sum, item|
      sum += item.unit_price
    end/item_count).round)
  end

  def golden_items
    minimum = minimum_for_golden_item
    se.items.items.reduce([]) do |result, item|
      if item.unit_price >= minimum
        result << item
      end
      result
    end
  end

  def minimum_for_golden_item
    average_item_price + (2 * standard_deviation_of_item_price)
  end

  def average_invoices_per_merchant
    (invoice_count.to_f / merchant_count).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    Math.sqrt(count_all_invoices_for_each_merchant.map do |invoice_count|
      (average_invoices_per_merchant - invoice_count) ** 2
    end.sum / (merchant_count - 1 )).round(2)
  end

  def count_all_invoices_for_each_merchant
    se.merchants.merchants.map do |merchant|
      merchant.invoices.count
    end
  end

  def top_merchants_by_invoice_count
    minimum_threshold = top_merchants_by_invoice_threshold
    se.merchants.merchants.reduce([]) do |result, merchant|
      if merchant.invoices.count >= minimum_threshold
        result << merchant
      end
      result
    end
  end

  def top_merchants_by_invoice_threshold
    twice_stdev = (2 * average_items_per_merchant_standard_deviation)
    average_invoices_per_merchant + twice_stdev
  end

  def bottom_merchants_by_invoice_count
    maximum_threshold = bottom_merchants_by_invoice_threshold
    se.merchants.merchants.reduce([]) do |result, merchant|
      if merchant.invoices.count <= maximum_threshold
        result << merchant
      end
      result
    end
  end

  def bottom_merchants_by_invoice_threshold
    twice_stdev = (2 * average_items_per_merchant_standard_deviation)
    return 0 if (average_invoices_per_merchant - twice_stdev) < 0
    average_invoices_per_merchant - twice_stdev
  end

  def top_days_by_invoice_count
    invoice_count_by_day.reduce([]) do |result, (day, count)|
      if count >= threshold_for_top_invoice_days
        result << day
      end
      result
    end
  end

  def threshold_for_top_invoice_days
    average_invoices_per_day + standard_deviation_of_invoices_per_day
  end

  def standard_deviation_of_invoices_per_day
    Math.sqrt(invoice_count_by_day.values.map do |value|
      (average_invoices_per_day - value) ** 2
    end.sum / (7 - 1 )).round(2)
  end

  def invoice_count_by_day
    se.invoices.invoices.reduce({}) do |result, invoice|
      day = invoice.created_at.strftime('%A')
      result[day] = 0 if result[day].nil?
      result[day] += 1
      result
    end
  end

  def average_invoices_per_day
    (invoice_count) / 7
  end

  def invoice_status(status)
    separated = invoice_status_accumulator
    BigDecimal((10000 * separated[status].to_f / invoice_count).round)/100
  end

  def invoice_status_accumulator
    se.invoices.invoices.reduce({}) do |result, invoice|
      result[invoice.status] = 0 if result[invoice.status].nil?
      result[invoice.status] += 1
      result
    end
  end
end

require 'bigdecimal'
require_relative './sales_engine'

class SalesAnalyst
  attr_reader :se, :invoice_count

  def initialize(sales_engine)
    @se = sales_engine
    @invoice_count = se.invoices.invoices.count
  end

  def average_items_per_merchant
    (se.items.items.count.to_f / se.merchants.merchants.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
      Math.sqrt(count_all_items_for_each_merchant.map do |item_count|
        (average_items_per_merchant - item_count) ** 2
      end.sum / (se.merchants.merchants.count - 1)).round(2)
  end

  def count_all_items_for_each_merchant
    se.merchants.merchants.map do |merchant|
      merchant.items.count
    end
  end

  def merchants_with_high_item_count
    se.merchants.merchants.reduce([]) do |result, merchant|
      if merchant.items.count >= minimum_for_high_items
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
    end/se.merchants.merchants.count)).round(2)
  end

  def standard_deviation_of_item_price
    Math.sqrt(se.items.items.map do |item|
      (average_item_price - item.unit_price) ** 2
    end.sum / (se.items.items.count - 1)).round(2)
  end

  def average_item_price
    BigDecimal((se.items.items.inject(0) do |sum, item|
      sum += item.unit_price
    end/se.items.items.count).round)
  end

  def golden_items
    se.items.items.reduce([]) do |result, item|
      if item.unit_price >= minimum_for_golden_item
        result << item
      end
      result
    end
  end

  def minimum_for_golden_item
    average_item_price + (2 * standard_deviation_of_item_price)
  end

  def average_invoices_per_merchant
    (se.invoices.invoices.count.to_f / se.merchants.merchants.count).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    Math.sqrt(count_all_invoices_for_each_merchant.map do |invoice_count|
      (average_invoices_per_merchant - invoice_count) ** 2
    end.sum / (se.merchants.merchants.count - 1 )).round(2)
  end

  def count_all_invoices_for_each_merchant
    se.merchants.merchants.map do |merchant|
      merchant.invoices.count
    end
  end

  def top_merchants_by_invoice_count
    se.merchants.merchants.reduce([]) do |result, merchant|
      if merchant.invoices.count >= top_merchants_by_invoice_threshold
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
    se.merchants.merchants.reduce([]) do |result, merchant|
      if merchant.invoices.count <= bottom_merchants_by_invoice_threshold
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
    (se.invoices.invoices.count) / 7
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

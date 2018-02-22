# frozen_string_literal: true

require_relative 'standard_deviation'

# Uses the sales engine to perform calculations
class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_item_cost
    items = @sales_engine.items.all
    costs = items.map { |item| item.unit_price.to_f }
    costs.reduce(:+) / costs.length.to_f
  end

  def item_cost_standard_deviation
    items = @sales_engine.items.all
    costs = items.map { |item| item.unit_price.to_f }
    StandardDeviation.calculate costs
  end

  def golden_items
    standard_deviation = item_cost_standard_deviation
    average_price = average_item_cost

    @sales_engine.items.all.select do |item|
      item.unit_price >= (average_price + standard_deviation * 2)
    end
  end

  def merchants_with_high_item_count
    count = merchant_item_count
    count_array = count.map { |merchant| merchant[:item_count] }
    deviation = StandardDeviation.calculate count_array
    average = count_array.reduce(:+) / count_array.length.to_f

    select_merchants deviation, average
  end

  def select_merchants(deviation, average)
    @sales_engine.merchants.all.select do |merchant|
      merchant.items.length >= average + deviation
    end
  end

  def merchant_item_count
    @sales_engine.merchants.all.map do |merchant|
      { id: merchant.id, item_count: merchant.items.length }
    end
  end

  def average_item_price_for_merchant(id)
    items = @sales_engine.merchants.find_by_id(id).items
    return 0 if items.empty?
    (items.map(&:unit_price).reduce(:+) / items.length).round 2
  end

  def average_average_price_per_merchant
    avgs = @sales_engine.merchants.all.map do |merchant|
      average_item_price_for_merchant merchant.id
    end
    average = (avgs.map(&:to_f).reduce(:+) / avgs.length.to_f).round 2
    BigDecimal.new average.to_s
  end

  def average_items_per_merchant
    merchants_items = @sales_engine.merchants.all.map do |merchant|
      merchant.items.length
    end
    (merchants_items.reduce(:+) / merchants_items.length.to_f).round 2
  end

  def average_items_per_merchant_standard_deviation
    merchants_items = @sales_engine.merchants.all.map do |merchant|
      merchant.items.length
    end
    (StandardDeviation.calculate merchants_items).round 2
  end

  def top_merchants_by_invoice_count
    invoice_count = invoice_count_by_merchant
    count = invoice_count.map do |merchant|
      merchant[:invoices]
    end

    avg = count.reduce(:+) / count.length.to_f
    deviation = StandardDeviation.calculate count

    ids = merchant_ids_with_high_invoice_count invoice_count, avg, deviation
    ids.map do |id|
      @sales_engine.merchants.find_by_id id
    end
  end

  def bottom_merchants_by_invoice_count
    invoice_count = invoice_count_by_merchant
    count = invoice_count.map do |merchant|
      merchant[:invoices]
    end

    avg = count.reduce(:+) / count.length.to_f
    deviation = StandardDeviation.calculate count

    ids = merchant_ids_with_low_invoice_count invoice_count, avg, deviation
    ids.map do |id|
      @sales_engine.merchants.find_by_id id
    end
  end

  def merchant_ids_with_high_invoice_count(merchants, avg, deviation)
    list = merchants.select do |merchant|
      merchant[:invoices] >= avg + (2 * deviation)
    end

    list.map do |merchant|
      merchant[:id]
    end
  end

  def merchant_ids_with_low_invoice_count(merchants, avg, deviation)
    list = merchants.select do |merchant|
      merchant[:invoices] <= avg - (2 * deviation)
    end

    list.map do |merchant|
      merchant[:id]
    end
  end

  def invoice_count_by_merchant
    @sales_engine.merchants.all.map do |merchant|
      { id: merchant.id, invoices: merchant.invoices.length }
    end
  end

  def invoice_status(status)
    count = invoice_status_count
    total = count.values.reduce(:+)
    (count[status] / total.to_f).round 2
  end

  def invoice_status_count
    invoices = @sales_engine.invoices.all
    grouped = invoices.group_by(&:status)
    grouped.reduce({}) do |result, (in_status, list)|
      result.update in_status => list.length
    end
  end

  def average_invoices_per_merchant
    merchants_invoices = @sales_engine.merchants.all.map do |merchants|
      merchants.invoices.length
    end
    (merchants_invoices.reduce(:+) / merchants_invoices.length.to_f). round 2
  end

  def average_invoices_per_merchant_standard_deviation
    merchants_invoices = @sales_engine.merchants.all.map do |merchant|
      merchant.invoices.length
    end
    (StandardDeviation.calculate merchants_invoices).round 2
  end

  def top_days_by_invoice_count
    res = @sales_engine.invoices.all.map do |invoice|
      invoice.created_at.strftime '%A'
    end
    binding.pry
  end
end

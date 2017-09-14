require 'bigdecimal'
require 'bigdecimal/util'

class SalesAnalyst
  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    (engine.items.all.length.to_f / engine.merchants.all.length.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    mean = engine.merchants.all.map do |merchant|
      (merchant.items.length - average_items_per_merchant)**2
    end
    Math.sqrt(mean.sum / (engine.merchants.all.count-1)).round(2)
  end

  def merchants_with_high_item_count
    count = average_items_per_merchant + average_items_per_merchant_standard_deviation
    engine.merchants.all.select do |merchant|
      merchant.items.count > count
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items       = engine.find_all_by_merchant_id(merchant_id)
    item_prices = items.map { |item| item.unit_price }
    (item_prices.sum / items.length).to_d.round(2)
  end

  def average_average_price_per_merchant
    averages = engine.merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    (averages.sum / engine.merchants.all.length).floor(2)
  end

  def golden_items
    count = (avg_item_price + avg_item_price_std_deviation * 2)
    engine.items.all.select {|item| item.unit_price > count}
  end

  def avg_item_price
    prices = engine.items.all.map{|item| item.unit_price}
    prices.sum / prices.count
  end

  def avg_item_price_std_deviation
    mean = engine.items.all.map do |item|
      (item.unit_price - avg_item_price)**2
    end
    Math.sqrt(mean.sum / engine.items.all.count).round(2)
  end

  def average_invoices_per_merchant
    (engine.invoices.all.count.to_f / engine.merchants.all.count.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    mean = engine.merchants.all.map do |merchant|
      (merchant.invoices.length - average_invoices_per_merchant)**2
    end
    Math.sqrt(mean.sum / (engine.merchants.all.count)).round(2)
  end

  def avg_invoice_standard_deviation
    mean = engine.merchants.all.map do |merchant|
      (merchant.invoices.length - avg_invoice_count)**2
    end
    Math.sqrt(mean.sum / engine.merchants.all.length).round(2)
  end

  def avg_invoice_count
    invoices = engine.merchants.all.map {|merchant| merchant.invoices.length}
    invoices.sum / invoices.length
  end

  def top_merchants_by_invoice_count
    count = (average_invoices_per_merchant + avg_invoice_standard_deviation * 2)
    engine.merchants.all.select {|merchant| merchant.invoices.length > count}
  end

  def bottom_merchants_by_invoice_count
    count = (average_invoices_per_merchant - avg_invoice_standard_deviation * 2)
    engine.merchants.all.select {|merchant| merchant.invoices.length < count}
  end

  def top_days_by_invoice_count
    days_with_high_invoices(day_array, avg_inv_per_day, invoice_std_deviation(invoices_per_day))
  end

  def invoice_std_deviation(invoices_per_day)
    Math.sqrt(invoices_per_day.map {|total| (total - avg_inv_per_day)**2}.sum / 7).round
  end

  def invoices_per_day
    grouped_invoices.values.map(&:length)
  end

  def day_array
    grouped_invoices.keys.zip(invoices_per_day)
  end

  def days_with_high_invoices(day_array, avg_inv_per_day, deviation)
    day_array.select do  |invoice|
      invoice[1] > avg_inv_per_day + deviation
   end.map {|arr| arr[0]}
  end

  def grouped_invoices
    engine.invoices.all.group_by {|invoice|invoice.created_at.strftime("%A")}
  end

  def avg_inv_per_day
    engine.invoices.all.length / 7
  end

  def invoice_status(status)
    total = engine.invoices.all.length
    selected  = engine.invoices.all.select {|invoice| invoice.status == status}
    ((selected.length.to_f / total.to_f) * 100.0).round(2)
  end
end

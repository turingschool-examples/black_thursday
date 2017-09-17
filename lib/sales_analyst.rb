require 'bigdecimal'
require 'bigdecimal/util'

class SalesAnalyst
  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    average(merchants.map {|merchant| merchant.items.length})
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(merchants.map {|merchant| merchant.items.length})
  end

  def merchants_with_high_item_count
    count = average_items_per_merchant + average_items_per_merchant_standard_deviation
    merchants.select {|merchant| merchant.items.count > count}
  end

  def average_item_price_for_merchant(merchant_id)
    items = engine.find_all_by_merchant_id(merchant_id)
    average(items.map(&:unit_price))
  end

  def average_average_price_per_merchant
     avg = merchants.map {|merchant|average_item_price_for_merchant(merchant.id)}
    (avg.sum / avg.length).floor(2)
  end

  def golden_items
    count = (avg_item_price + avg_item_price_std_deviation * 2)
    items.select {|item| item.unit_price > count}
  end

  def avg_item_price
    average(items.map(&:unit_price))
  end

  def avg_item_price_std_deviation
    standard_deviation(items.map(&:unit_price))
  end

  def average_invoices_per_merchant
    average(merchants.map {|merchant| merchant.invoices.length})
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(merchants.map {|merchant| merchant.invoices.length})
  end

  def top_merchants_by_invoice_count
    mean      = average_invoices_per_merchant
    deviation = average_invoices_per_merchant_standard_deviation
    count     = mean + (deviation * 2)
    merchants.select {|merchant| merchant.invoices.length > count}
  end

  def bottom_merchants_by_invoice_count
    mean      = average_invoices_per_merchant
    deviation = average_invoices_per_merchant_standard_deviation
    count     = mean - (deviation * 2)
    merchants.select {|merchant| merchant.invoices.length < count}
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
    day_array.select {|invoice| invoice[1] > avg_inv_per_day + deviation}.map(&:first)
  end

  def grouped_invoices
    invoices.group_by {|invoice|invoice.created_at.strftime("%A")}
  end

  def avg_inv_per_day
    invoices.length / 7
  end

  def invoice_status(status)
    total     = invoices.length
    selected  = invoices.select {|invoice| invoice.status == status}
    ((selected.length.to_f / total.to_f) * 100.0).round(2)
  end

  def items
    engine.items.all
  end

  def invoices
    engine.invoices.all
  end

  def merchants
    engine.merchants.all
  end

  def average(collection)
    (collection.sum / collection.length.to_f).round(2)
  end

  def standard_deviation(collection)
    Math.sqrt(s_d_numerator(collection) / collection.length).round(2)
  end

  def squared_diff(number, average)
    (number - average)**2
  end

  def s_d_numerator(collection)
    collection.map {|number| squared_diff(number, average(collection))}.sum
  end

  def total_revenue_by_date(date)
    date = date.to_s.split(" ")[0]
    invoice = invoices.select {|item| item.created_at.to_s.split(" ")[0] == date}
    invoice.map {|invoice| invoice.total}.sum
  end

  def top_revenue_earners(x = 20)
    ranked_merchant.reverse.take(x)
  end

  def ranked_merchant
    ranked_merchants_by_revenue.map! {|merchant| engine.merchants.find_by_id(merchant.first)}
  end

  def ranked_merchants_by_revenue
    paired_merchant_invoice.sort_by { |merchant| merchant[1] }
  end

  def paired_merchant_invoice
    merchant_invoices.keys.zip(total_revenue_by_merchant)
  end

  def total_revenue_by_merchant
    revenue_by_merchant.values.map! {|invoices| invoices.sum}
  end

  def revenue_by_merchant
    merchant_invoices.each_value { |invoices| invoices.map! { |invoice| invoice.total } }
  end

  def merchant_invoices
    invoices.group_by {|invoice| invoice.merchant_id}
  end
end

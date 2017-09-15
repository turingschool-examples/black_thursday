require 'bigdecimal'
require 'bigdecimal/util'

class SalesAnalyst
  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    average(merchants.map {|merchant| merchant.items.length})
    # (items.length.to_f / merchants.length.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(merchants.map {|merchant| merchant.items.length})
    # mean = merchants.map do |merchant|
    #   (merchant.items.length - average_items_per_merchant)**2
    # end
    # Math.sqrt(mean.sum / (merchants.count-1)).round(2)
  end

  def merchants_with_high_item_count
    count = average_items_per_merchant + average_items_per_merchant_standard_deviation
    merchants.select {|merchant| merchant.items.count > count}
  end

  def average_item_price_for_merchant(merchant_id)
    items = engine.find_all_by_merchant_id(merchant_id)
    average(items.map(&:unit_price))
    # average(items.map { |item| item.unit_price })
    # item_prices = items.map { |item| item.unit_price }
    # (item_prices.sum / items.length).to_d.round(2)
  end

  def average_average_price_per_merchant
    averages = merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    (averages.sum / averages.length).floor(2)
  end

  def golden_items
    count = (avg_item_price + avg_item_price_std_deviation * 2)
    items.select {|item| item.unit_price > count}
  end

  def avg_item_price
    average(items.map{|item| item.unit_price})
    # prices = items.map{|item| item.unit_price}
    # prices.sum / prices.count
  end

  def avg_item_price_std_deviation
    mean = items.map do |item|
      (item.unit_price - avg_item_price)**2
    end
    Math.sqrt(mean.sum / items.count).round(2)
  end

  def average_invoices_per_merchant
    (invoices.count.to_f / merchants.count.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    mean = merchants.map do |merchant|
      (merchant.invoices.length - average_invoices_per_merchant)**2
    end
    Math.sqrt(mean.sum / (merchants.count)).round(2)
  end

  def avg_invoice_standard_deviation
    mean = merchants.map do |merchant|
      (merchant.invoices.length - avg_invoice_count)**2
    end
    Math.sqrt(mean.sum / merchants.length).round(2)
  end

  def avg_invoice_count
    average(merchants.map {|merchant| merchant.invoices.length})
    # invoices = merchants.map {|merchant| merchant.invoices.length}
    # invoices.sum / invoices.length
  end

  def top_merchants_by_invoice_count
    count = (average_invoices_per_merchant + avg_invoice_standard_deviation * 2)
    merchants.select {|merchant| merchant.invoices.length > count}
  end

  def bottom_merchants_by_invoice_count
    count = (average_invoices_per_merchant - avg_invoice_standard_deviation * 2)
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
    day_array.select do  |invoice|
      invoice[1] > avg_inv_per_day + deviation
   end.map {|arr| arr[0]}
  end

  def grouped_invoices
    invoices.group_by {|invoice|invoice.created_at.strftime("%A")}
  end

  def avg_inv_per_day
    invoices.length / 7
  end

  def invoice_status(status)
    total = invoices.length
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
end
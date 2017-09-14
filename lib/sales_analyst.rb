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
    grouped = engine.invoices.all.group_by do |invoice|
      invoice.created_at.strftime("%A")
    end
    # invoices_p_day  = grouped.values.map {|day| day.count}
    # day_array       = grouped.keys.zip(invoices_p_day)
    # day_hash        = day_array.reduce({}) {|hash, arr| hash[arr[0]]  = arr[1]; hash}
    # avg_inv_per_day = engine.invoices.all.length / 7
    # diff            = invoices_p_day.map {|total| (total - avg_inv_per_day)**2}
    # deviation       = Math.sqrt(diff.sum / 7).round
    # above_deviation = day_hash.find_all do |invoice| 
    #   invoice[1] > avg_inv_per_day + deviation
    # end

    invoices_p_day  = grouped.values.map {|day| day.count}
    day_array       = grouped.keys.zip(invoices_p_day)
    # day_hash        = day_array.reduce({}) {|hash, arr| hash[arr[0]]  = arr[1]; hash}
    avg_inv_per_day = engine.invoices.all.length / 7
    diff            = invoices_p_day.map {|total| (total - avg_inv_per_day)**2}
    deviation       = Math.sqrt(diff.sum / 7).round
    above_deviation = day_array.select do |invoice|
      invoice[1] > avg_inv_per_day + deviation
    end
    above_deviation.map {|arr| arr[0]}
  end
end

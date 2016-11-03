require 'pry'
class SalesAnalyst

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    items = sales_engine.items.all.count.to_f
    merchants = sales_engine.all_merchants.count.to_f
    (items / merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(items_per_merchant_std_dev_numerator / items_per_merchant_std_dev_denominator).round(2)
  end

  def items_per_merchant_std_dev_numerator
    sales_engine.all_merchants.map do |merchant|
      items_per_merchant_distance_from_mean_squared(merchant.items.count)
    end.reduce(:+).to_f
  end

  def items_per_merchant_distance_from_mean_squared(item_count)
    ((item_count - average_items_per_merchant) ** 2).to_f
  end

  def items_per_merchant_std_dev_denominator
    (sales_engine.all_merchants.count - 1).to_f
  end

  def merchants_with_high_item_count
    mean    = average_items_per_merchant
    std_dev = average_items_per_merchant_standard_deviation
    sales_engine.all_merchants.find_all do |merchant|
      merchant.items.count > (mean + std_dev)
    end
  end

  def average_item_price_for_merchant(id)
    items = sales_engine.merchants.find_by_id(id).items
    return 0 if items.empty?
    prices = items.map do |row|
      row.unit_price
    end.reduce(:+) / items.count
    prices.round(2)
  end

  def average_average_price_per_merchant
    merchants = sales_engine.all_merchants
    (merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end.reduce(:+) / merchants.count).round(2)
  end

  def golden_items
    mean    = average_price
    std_dev = item_price_standard_deviation
    items = sales_engine.all_items
    items.find_all do |item|
      item.unit_price > (mean + (std_dev * 2))
    end
  end

  def average_price
    sales_engine.items.all.map {|item| item.unit_price}.reduce(:+) / sales_engine.items.all.count
  end

  def item_price_standard_deviation
    items = sales_engine.all_items
    stdev = items.map do |item|
      (item.unit_price - average_price) ** 2
    end.reduce(:+) / (items.count - 1)
    Math.sqrt(stdev).round(2)
  end

  def average_invoices_per_merchant
    invoices = sales_engine.all_invoices.count.to_f
    merchants = sales_engine.all_merchants.count.to_f
    (invoices / merchants).round(2)
  end

  def top_days_by_invoice_count
    
  def invoice_status(invoice_status)
    status = find_all_statuses(:status, invoice_status).count.to_f
    count = sales_engine.all_invoices.count.to_f
    ((status / count) * 100).round(2)
  end

  def find_all_statuses(method, invoice_status)
    sales_engine.all_invoices.find_all do |row|
      row = row.send(method).downcase
      row.include?(invoice_status.downcase)
    end
  end
end

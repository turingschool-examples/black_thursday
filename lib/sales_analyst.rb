require 'bigdecimal'

class SalesAnalyst

  WEEKDAYS = {"0" => "Sunday", "1" => "Monday", "2" => "Tuesday",
              "3" => "Wednesday", "4" => "Thursday", "5" => "Friday",
              "6" => "Saturday"}

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def items_per_merchant
    merchants_items = sales_engine.get_all_merchant_items.values
    merchants_items.map do |merchant_items|
      BigDecimal.new(merchant_items.count)
    end
  end

  def average_items_per_merchant
    (items_per_merchant.sum / items_per_merchant.count).to_f.round(2)
  end

  def average_items_per_merchant_standard_deviation
    variance = items_per_merchant.map do |number_of_items|
      ((average_items_per_merchant - number_of_items)) ** 2
    end.sum / (items_per_merchant.count - 1)
    Math.sqrt(variance).round(2)
  end

  def merchants_with_high_item_count
    stdev = average_items_per_merchant_standard_deviation
    sales_engine.get_all_merchant_items.map do |merchant, items|
      merchant if items.count > average_items_per_merchant + stdev
    end.compact
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_prices = sales_engine.get_one_merchant_prices(merchant_id)
    (merchant_prices.sum / merchant_prices.count).round(2)
  end

  def average_average_price_per_merchant
    merchants_prices = sales_engine.get_all_merchant_prices.values
    full_average = merchants_prices.map do |merchant_prices|
      merchant_prices.sum / merchant_prices.count
    end.sum / merchants_prices.count
    full_average.round(2)
  end

  def all_item_prices
    sales_engine.get_all_merchant_prices.values.flatten
  end

  def average_item_price
    all_item_prices.sum / all_item_prices.count
  end

  def item_prices_standard_deviation
    variance = all_item_prices.map do |item_price|
      ((average_item_price - item_price).abs) ** 2
    end.sum / (all_item_prices.count - 1)
    Math.sqrt(variance)
  end

  def golden_prices
    golden_limit = average_item_price + (2 * item_prices_standard_deviation)
    all_item_prices.select do |item_price|
      item_price >= golden_limit
    end.uniq
  end

  def golden_items
    golden_prices.map do |golden_price|
      sales_engine.search_ir_by_price(golden_price)
    end.flatten
  end

  def invoice_count_per_merchant
    merchants_invoices = sales_engine.get_all_merchant_invoices
    merchants_invoices.transform_values do |invoices|
      invoices.count.to_f
    end
  end

  def average_invoices_per_merchant
    (invoice_count_per_merchant.values.sum / invoice_count_per_merchant.count).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    variance = invoice_count_per_merchant.values.map do |invoice_count|
      ((average_invoices_per_merchant - invoice_count).abs) ** 2
    end.sum / (invoice_count_per_merchant.count - 1)
    Math.sqrt(variance).round(2)
  end

# CAN WE DO SAME BELOW FOR GOLDEN ITEMS?
  def top_merchants_by_invoice_count
    limit = average_invoices_per_merchant + (2 * average_invoices_per_merchant_standard_deviation)
    invoice_count_per_merchant.select do |merchant, invoice_count|
      invoice_count >= limit
    end.keys
  end

  def bottom_merchants_by_invoice_count
    limit = average_invoices_per_merchant - (2 * average_invoices_per_merchant_standard_deviation)
    invoice_count_per_merchant.select do |merchant, invoice_count|
      invoice_count <= limit
    end.keys
  end

  def invoices_per_weekday
    sales_engine.invoices.all.group_by do |invoice|
      date_time = DateTime.strptime(invoice.created_at.to_s, '%Y-%m-%d')
      date_time.wday.to_s.gsub(/[0-6]/, WEEKDAYS)
    end
  end

  def invoice_counts_per_weekday
    invoices_per_weekday.transform_values do |invoices|
      invoices.count
    end
  end

  def average_invoice_counts_per_day
    average_counts = invoice_counts_per_weekday.values.sum / 7.0
    BigDecimal.new(average_counts, 4)
  end

  def average_invoices_per_day_standard_deviation
    variance = invoice_counts_per_weekday.values.map do |invoice_count|
      (average_invoice_counts_per_day - invoice_count) ** 2
    end.sum / (invoice_counts_per_weekday.count - 1)
    Math.sqrt(variance).round(2)
  end

  def top_days_by_invoice_count
    limit = average_invoice_counts_per_day + average_invoices_per_day_standard_deviation
    top_days = invoice_counts_per_weekday.select do |day, count|
      count >= limit
    end.keys
    sort_by_weekday(top_days)
  end

  def sort_by_weekday(weekday_array)
    days_as_numbers = weekday_array.map { |element| WEEKDAYS.invert[element] }
    days_as_numbers.sort.map { |element| WEEKDAYS[element] }
  end

  def invoice_status(status)
    all_invoices = sales_engine.invoices.all
    invoices_by_status = all_invoices.select do |invoice|
      invoice.status == status.to_sym
    end
    status_ratio = ((all_invoices.count - invoices_by_status.count) / all_invoices.count.to_f)
    ((1 - status_ratio) * 100).round(2)
    #do we want status percentage to be bigdecimal?
  end

end

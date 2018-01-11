require 'bigdecimal'

class SalesAnalyst

  WEEKDAYS = {"0" => "Sunday", "1" => "Monday", "2" => "Tuesday",
              "3" => "Wednesday", "4" => "Thursday", "5" => "Friday",
              "6" => "Saturday"}

  MONTHS = {"1" => "January", "2" => "February", "3" => "March",
            "4" => "April", "5" => "May", "6" => "June",
            "7" => "July", "8" => "August", "9" => "September",
            "10" => "October", "11" => "November", "12" => "December"}

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine ||= sales_engine
  end

  def items_per_merchant
    merchants_items = sales_engine.merchants_with_items.values
    merchants_items.map do |merchant_items|
      BigDecimal.new(merchant_items.count)
    end
  end

  def average_items_per_merchant
    (items_per_merchant.sum / items_per_merchant.count).to_f.round(2)
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    variance = items_per_merchant.map do |number_of_items|
      ((average - number_of_items)) ** 2
    end.sum / (items_per_merchant.count - 1)
    Math.sqrt(variance).round(2)
  end

  def merchants_with_high_item_count
    stdev = average_items_per_merchant_standard_deviation
    limit = average_items_per_merchant + stdev
    sales_engine.merchants_with_items.map do |merchant, items|
      merchant if items.count > limit
    end.compact
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_prices = sales_engine.get_prices_from_one_merchant(merchant_id)
    (merchant_prices.sum / merchant_prices.count).round(2)
  end

  def average_average_price_per_merchant
    merchants_prices = sales_engine.merchants_with_prices.values
    full_average = merchants_prices.map do |merchant_prices|
      merchant_prices.sum / merchant_prices.count
    end.sum / merchants_prices.count
    full_average.round(2)
  end

  def all_item_prices
    sales_engine.merchants_with_prices.values.flatten
  end

  def average_item_price
    all_item_prices.sum / all_item_prices.count
  end

  def item_prices_standard_deviation
    average = average_item_price
    variance = all_item_prices.map do |item_price|
      (average - item_price) ** 2
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
      sales_engine.get_items_by_price(golden_price)
    end.flatten
  end

  def invoice_count_per_merchant
    merchants_invoices = sales_engine.merchants_with_invoices
    merchants_invoices.transform_values do |invoices|
      invoices.count.to_f
    end
  end

  def average_invoices_per_merchant
    sum = invoice_count_per_merchant.values.sum
    count = invoice_count_per_merchant.count
    (sum / count).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    average = average_invoices_per_merchant
    variance = invoice_count_per_merchant.values.map do |invoice_count|
      (average - invoice_count) ** 2
    end.sum / (invoice_count_per_merchant.count - 1)
    Math.sqrt(variance).round(2)
  end

  def top_merchants_by_invoice_count
    doubled_stdev = 2 * average_invoices_per_merchant_standard_deviation
    limit = average_invoices_per_merchant + doubled_stdev
    invoice_count_per_merchant.select do |merchant, invoice_count|
      invoice_count >= limit
    end.keys
  end

  def bottom_merchants_by_invoice_count
    doubled_stdev = 2 * average_invoices_per_merchant_standard_deviation
    limit = average_invoices_per_merchant - doubled_stdev
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
    average = average_invoice_counts_per_day
    variance = invoice_counts_per_weekday.values.map do |invoice_count|
      (average - invoice_count) ** 2
    end.sum / (invoice_counts_per_weekday.count - 1)
    Math.sqrt(variance).round(2)
  end

  def top_days_by_invoice_count
    stdev = average_invoices_per_day_standard_deviation
    limit = average_invoice_counts_per_day + stdev
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
    all = sales_engine.invoices.all
    invoices_by_status = all.select do |invoice|
      invoice.status == status.to_sym
    end
    status_ratio = ((all.count - invoices_by_status.count) / all.count.to_f)
    ((1 - status_ratio) * 100).round(2)
  end

  def total_revenue_by_date(date)
    price_array = sales_engine.get_invoice_items_total_cost_by_date(date)
    price_array.sum
  end

  def merchants_ranked_by_revenue
    missing = sales_engine.missing_merchant_ids.keys.map do |merchant_id|
      sales_engine.get_merchant_from_merchant_id(merchant_id)
    end
    (top_revenue_earners(sales_engine.merchants.all.count) + missing).uniq
  end

  def top_earners_ids(number_of_merchants)
    all_merchants_revenues = sales_engine.merchant_ids_with_total_revenue
    top_earners_revenues = all_merchants_revenues.sort_by do |merchant, revenue|
      revenue
    end.reverse.slice(0..(number_of_merchants - 1))
    top_earners_revenues.map do |top_earners|
      top_earners[0]
    end
  end

  def top_revenue_earners(number_of_merchants=20)
    top_earners_ids(number_of_merchants).map do |merchant_id|
      sales_engine.get_merchant_from_merchant_id(merchant_id)
    end
  end

  def merchants_with_pending_invoices
    sales_engine.get_merchants_with_pending_invoices
  end

  def merchants_with_only_one_item
    sales_engine.merchants_with_items.select do |merchant, items|
      items.count == 1
    end.keys
  end

  def one_item_merchants_by_month
    merchants_with_only_one_item.group_by do |merchant|
      Date.parse(merchant.created_at.to_s).month
    end
  end

  def merchants_with_only_one_item_registered_in_month(month_name)
    one_item_merchants_by_month.select do |month_num, merchants|
      MONTHS.invert[month_name].to_i == month_num
    end.values.flatten
  end

  def revenue_by_merchant(merchant_id)
    sales_engine.merchant_ids_with_total_revenue[merchant_id]
  end

  def most_sold_item_for_merchant(merchant_id)
    sales_engine.link_merchant_ids_with_most_sold_items[merchant_id]
  end

  def best_item_for_merchant(merchant_id)
    sales_engine.link_merchant_ids_with_best_items[merchant_id]
  end

end

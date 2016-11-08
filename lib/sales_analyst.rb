require 'bigdecimal'
require_relative 'statistics'

class SalesAnalyst
  include Statistics

  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def all_merchants
    engine.merchants.all
  end

  def all_items
    engine.items.all
  end

  def merchant_item_count
    engine.merchants.merchant_item_count
  end

  def merchant_invoice_count
    engine.merchants.all.map { |m| m.invoices.count }
  end

  def average_items_per_merchant
    find_average(merchant_item_count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    stdev(merchant_item_count).round(2)
  end

  def merchants_with_high_item_count
    threshold = stdev(merchant_item_count) + find_average(merchant_item_count)
    merchant_outliers = all_merchants.find_all { |m| m.items.count > threshold }
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = engine.merchants.find_by_id(merchant_id)
    item_prices = merchant.items.map { |i| i.unit_price }
    BigDecimal(find_average(item_prices)).round(2)
  end

  def average_average_price_per_merchant
    merchant_ids = all_merchants.map {|m| m.id}
    average_prices = merchant_ids.map {|id| average_item_price_for_merchant(id)}
    BigDecimal(find_average(average_prices)).round(2)
  end

  def golden_items
    items_prices = all_items.map { |i| i.unit_price }
    threshold = (stdev(items_prices) * 2) + find_average(items_prices)
    all_items.find_all { |i| i.unit_price >= threshold }
  end

  def average_invoices_per_merchant
    find_average(merchant_invoice_count).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    stdev(merchant_invoice_count).round(2)
  end

  def top_merchants_by_invoice_count
    threshold = (stdev(merchant_invoice_count) * 2)
    threshold += find_average(merchant_invoice_count)
    all_merchants.find_all { |m| m.invoices.count > threshold }
  end

  def bottom_merchants_by_invoice_count
    threshold = find_average(merchant_invoice_count)
    threshold -= (stdev(merchant_invoice_count) * 2)
    all_merchants.find_all { |m| m.invoices.count < threshold }
  end

  def top_days_by_invoice_count
    day_hash = engine.invoices.all.group_by {|i| i.created_at.wday}
    day_data = day_hash.values.map { |day| day.count}
    threshold = (stdev(day_data) + find_average(day_data)).round
    top_days = day_hash.keys.find_all { |day| day_hash[day].count > threshold }
    top_days.map { |day| day_accessor[day] }
  end

  def invoice_status(status_symbol)
    numerator = engine.invoices.find_all_by_status(status_symbol).count
    denominator = engine.invoices.all.count
    ((numerator.to_f / denominator) * 100).round(2)
  end

  def total_revenue_by_date(date)
    dated_invoice = engine.invoices.find_all_by_date(date)
    dated_invoice.reduce(0) do |sum, invoice|
      sum += invoice.total
      sum
    end
  end

  def top_revenue_earners(number = 20)
    sorted = merchants_ranked_by_revenue
    sorted[0..(number-1)]
  end

  def merchants_ranked_by_revenue
    invoice_ids = engine.invoices.all.group_by { |i| i.merchant_id }
    invoice_ids.each_key do |merchant_id|
      invoice_ids[merchant_id] = revenue_by_merchant(merchant_id)
    end
    sorted = sort_grouped(invoice_ids)
    sorted.map { |merchant_pair| engine.merchants.find_by_id(merchant_pair[0]) }
  end

  def revenue_by_merchant(merchant_id)
    invoices_by_merchant = engine.invoices.find_all_by_merchant_id(merchant_id)
    invoices_by_merchant.reduce(0) do |sum, invoice|
      sum += invoice.total
      sum
    end
  end

  def merchants_with_pending_invoices
    pending = engine.invoices.all.find_all {|i| i.is_paid_in_full? == false }
    pending_merchants = pending.map {|i| i.merchant }.uniq
  end

  def merchants_with_only_one_item
    all_merchants.find_all {|m| m.items.count == 1}
  end

  def merchants_with_only_one_item_registered_in_month(desired_month)
    registered_then = engine.merchants.all.find_all  do |m|
      m.created_at.month == month_accessor[desired_month.capitalize]
    end
    registered_then.find_all { |m| m.items.count == 1 }
  end

  def month_accessor
    { 'January'   =>1,
      'February'  =>2,
      'March'     =>3,
      'April'     =>4,
      'May'       =>5,
      'June'      =>6,
      'July'      =>7,
      'August'    =>8,
      'September' =>9,
      'October'   =>10,
      'November'  =>11,
      'December'  =>12}
  end

  def day_accessor
    { 0 => "Sunday",
      1 => "Monday",
      2 => "Tuesday",
      3 => "Wednesday",
      4 => "Thursday",
      5 => "Friday",
      6 => "Saturday"}
  end

  def most_sold_item_for_merchant(merchant_id)
    sorted = pull_merchants_sold_items(merchant_id)
    sorted.each_key do |item_id|
      sorted[item_id] = add_quantities(sorted[item_id])
    end
    final_sorted = sort_grouped(sorted)
    top_items = final_sorted.find_all {|el| el[1] == final_sorted[0][1]}
    top_items.map {|el| engine.items.find_by_id(el[0]) }
  end

  def sort_grouped(grouped)
    grouped.sort_by{|key, value| value}.reverse
  end

  def add_quantities(invoice_items)
    invoice_items.reduce(0) do |sum, ii|
      sum += ii.quantity
      sum
    end
  end

  def pull_merchants_sold_items(merchant_id)
    merchant_invoices = engine.merchants.find_by_id(merchant_id).invoices
    merchant_invoices = merchant_invoices.find_all { |i| i.is_paid_in_full? }
    sold_items = merchant_invoices.map { |i| i.invoice_items }.flatten
    sold_items.group_by { |ii| ii.item_id }
  end

  def reduce_revenue(invoice_items)
    invoice_items.reduce(0) do |sum, ii|
      sum += (ii.quantity * ii.unit_price)
      sum
    end
  end

  def best_item_for_merchant(merchant_id)
    sold_items = pull_merchants_sold_items(merchant_id)
    sold_items.each_key do |item_id|
      sold_items[item_id] = reduce_revenue(sold_items[item_id])
    end
    final_sorted = sort_grouped(sold_items)
    engine.items.find_by_id(final_sorted[0][0])
  end

end
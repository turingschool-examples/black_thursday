require 'bigdecimal'
# Class that analyzes sales data
class SalesAnalyst
  attr_reader :engine

  def initialize(sales_engine)
    @engine = sales_engine
  end

  def average_items_per_merchant
    items = @engine.items.elements.count.to_f
    merchants = @engine.merchants.elements.count.to_f
    (items / merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    merchants = @engine.merchants.all.map do |merchant|
      @engine.items.find_all_by_merchant_id(merchant.id).count
    end
    average = average_items_per_merchant
    standard_deviation(merchants, average)
  end

  def merchants_with_high_item_count
    threshold = average_items_per_merchant +
                (average_items_per_merchant_standard_deviation * 1)
    @engine.merchants.all.find_all do |merchant|
      merch_count = @engine.items.find_all_by_merchant_id(merchant.id).count
      merch_count > threshold
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items = @engine.items.find_all_by_merchant_id(merchant_id)
    total_cost = 0.0
    items.each do |item|
      total_cost += item.unit_price
    end
    (total_cost / items.count).round(2)
  end

  def average_average_price_per_merchant
    merchants = @engine.merchants.all
    total_cost = 0.0
    merchants.each do |merchant|
      total_cost += average_item_price_for_merchant(merchant.id)
    end
    (total_cost / merchants.count).round(2)
  end

  def average_item_cost
    items = @engine.items.all
    total_cost = 0.0
    items.each do |item|
      total_cost += item.unit_price
    end
    (total_cost / items.count).round(2)
  end

  def golden_items
    threshold = average_item_cost +
                (item_unit_price_standard_deviation * 2)
    @engine.items.all.find_all do |item|
      item.unit_price > threshold
    end
  end

  def item_unit_price_standard_deviation
    items = @engine.items.all.map do |item|
      item.unit_price
    end
    average = average_item_cost
    standard_deviation(items, average)
  end

  def standard_deviation(elements, average)
    deviation_sum = 0
    elements.each do |element|
      deviation_sum += (element.to_f - average).abs**2
    end
    divided_deviation = deviation_sum / (elements.count - 1)
    Math.sqrt(divided_deviation).round(2).to_f
  end

  def average_invoices_per_merchant
    invoices = @engine.invoices.elements.count.to_f
    merchants = @engine.merchants.elements.count.to_f
    (invoices / merchants).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    merchants = @engine.merchants.all.map do |merchant|
      @engine.invoices.find_all_by_merchant_id(merchant.id).count
    end
    average = average_invoices_per_merchant
    standard_deviation(merchants, average)
  end

  def top_merchants_by_invoice_count
    threshold = average_invoices_per_merchant +
                (average_invoices_per_merchant_standard_deviation * 2)
    @engine.merchants.all.find_all do |merchant|
      merch_count = @engine.invoices.find_all_by_merchant_id(merchant.id).count
      merch_count > threshold
    end
  end

  def bottom_merchants_by_invoice_count
    threshold = average_invoices_per_merchant -
                (average_invoices_per_merchant_standard_deviation * 2)
    @engine.merchants.all.find_all do |merchant|
      merch_count = @engine.invoices.find_all_by_merchant_id(merchant.id).count
      merch_count < threshold
    end
  end

  def top_days_by_invoice_count
    days = generate_day
    average = average_days(days)
    stnd_dev = standard_deviation(days.values, average)
    threshold = average + (stnd_dev * 1)
    top_day_numbers = top_days(days, threshold)
    top_day_numbers.map do |day|
      Date::DAYNAMES[day]
    end
  end

  def top_days(days, threshold)
    top_days = days.find_all do |day|
      day[1] > threshold
    end
    top_days.map do |day|
      day[0]
    end
  end

  def average_days(days)
    days.values.reduce(0) do |sum, num|
      sum + num
    end / 7
  end

  def generate_day
    days = @engine.invoices.all.group_by do |invoice|
      invoice.created_at.wday
    end
    days.map do |day, invoices|
      [day, invoices.count]
    end.to_h
  end

  def invoice_by_day_standard_deviation
    days = generate_day
    average = average_days(days)
    standard_deviation(days.values, average)
  end

  def invoice_status(status)
    statuses = @engine.invoices.all.group_by(&:status)
    mapped_statuses = statuses.map do |status, invoices|
      [status, invoices.count]
    end.to_h
    final = mapped_statuses[status].to_f / @engine.invoices.all.count.to_f
    (final * 100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    transactions = @engine.transactions.find_all_by_invoice_id(invoice_id)
    transactions.any? do |transaction|
      transaction.result == :success
    end
  end

  def invoice_total(invoice_id)
    invoice_items = @engine.invoice_items.find_all_by_invoice_id(invoice_id)
    total = 0
    invoice_items.each do |invoice_item|
      total += invoice_item.unit_price * invoice_item.quantity
    end
    total
  end

  def total_revenue_by_date(date)
    invoices = @engine.invoices.all.find_all do |invoice|
      invoice.created_at == date
    end
    total = 0
    invoices.each do |invoice|
      total += invoice_total(invoice.id)
    end
    total
  end

  def top_revenue_earners(num = 20)
    merchants_ranked_by_revenue[0..num-1]
  end

  def merchants_ranked_by_revenue
    tops = @engine.merchants.all.sort_by do |merchant|
      invoices = @engine.invoices.find_all_by_merchant_id(merchant.id)
      invoices.reduce(0, &method(:revenue_for_invoice))
    end.reverse
    tops
  end

  def revenue_for_invoice(total, invoice)
    return total unless invoice_paid_in_full?(invoice.id)
    total + invoice_total(invoice.id)
  end
end

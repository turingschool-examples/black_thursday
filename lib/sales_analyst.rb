require_relative 'statistics'
require 'date'

class SalesAnalyst

  include Statistics

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def items
    sales_engine.all_items
  end

  def merchants
    sales_engine.all_merchants
  end

  def invoices
    sales_engine.all_invoices
  end

  def average_items_per_merchant
    average(merchants.map{ |merchant| merchant.items.count })
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(merchants.map {|merchant| merchant.items.count})
  end

  def merchants_with_high_item_count
    mean       = average_items_per_merchant
    std_dev    = average_items_per_merchant_standard_deviation
    threshhold = mean + std_dev
    merchants.find_all { |merchant| merchant.items.count > threshhold }
  end

  def average_item_price_for_merchant(id)
    merch_items = sales_engine.merchants.find_by_id(id).items
    return 0 if merch_items.empty?
    average(merch_items.map{|row| row.unit_price})
  end

  def average_average_price_per_merchant
    averages = merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    average(averages)
  end

  def golden_items
    mean       = average_item_price
    std_dev    = item_price_standard_deviation
    threshhold = mean + (std_dev * 2)
    items.find_all { |item| item.unit_price > threshhold }
  end

  def average_item_price
    average(items.map { |item| item.unit_price })
  end

  def item_price_standard_deviation
    standard_deviation(items.map { |item| item.unit_price })
  end

  def average_invoices_per_merchant
    average(merchants.map { |merchant| merchant.invoices.count })
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(merchants.map { |merchant| merchant.invoices.count })
  end

  def top_merchants_by_invoice_count
    mean       = average_invoices_per_merchant
    std_dev    = average_invoices_per_merchant_standard_deviation
    threshhold = mean + (std_dev * 2)
    merchants.find_all { |merchant| merchant.invoices.count > threshhold }
  end

  def bottom_merchants_by_invoice_count
    mean       = average_invoices_per_merchant
    std_dev    = average_invoices_per_merchant_standard_deviation
    threshhold = mean - (std_dev * 2)
    merchants.find_all { |merchant| merchant.invoices.count < threshhold }
  end

  def top_days_by_invoice_count
    mean       = average_invoices_per_day
    std_dev    = average_invoices_per_day_standard_deviation
    threshhold = mean + std_dev
    invoices_by_day.keys.find_all { |day| invoices_by_day[day] > threshhold }
  end

  def invoices_by_day
    invoice_days.reduce ({}) do |result, day|
      result[day]  = 0 if result[day].nil?
      result[day] += 1
      result
    end
  end

  def invoice_days
    invoices.map {|invoice| Date::DAYNAMES[invoice.created_at.wday]}
  end

  def average_invoices_per_day
    average(invoices_by_day.values)
  end

  def average_invoices_per_day_standard_deviation
    standard_deviation(invoices_by_day.values)
  end

  def invoice_status(invoice_status)
    status = all_invoices_by_status(invoice_status).count.to_f
    count  = invoices.count.to_f
    ((status / count) * 100).round(2)
  end

  def all_invoices_by_status(invoice_status)
    invoices.find_all { |row| row.status.to_sym == invoice_status.to_sym }
  end

  def total_revenue_by_date(date)
    total = invoices_total(invoices_on_date(date))
    return total.round(2) if total
    0
  end

  def invoices_on_date(date)
    date = date.strftime('%F')
    invoices.find_all do |invoice|
      invoice.created_at.strftime('%F') == date
    end
  end

  def top_revenue_earners(number = 20)
    merchants_ranked_by_revenue.first(number)
  end

  def merchants_ranked_by_revenue
    sorted = merchants_and_invoices.keys.sort_by do |merchant|
      invoices_total(merchants_and_invoices[merchant])
    end.reverse
    sorted.map { |merchant_id| sales_engine.merchants.find_by_id(merchant_id) }
  end

  def invoices_total(invoices)
    invoices.map { |invoice| invoice.total }.reduce(:+)
  end

  def merchants_and_invoices
    invoices.group_by { |invoice| invoice.merchant_id }
  end

  def merchants_with_pending_invoices
    pending_invoices.map { |pender| pender.merchant }.uniq
  end

  def pending_invoices
    invoices.find_all { |invoice| pending?(invoice) }
  end

  def pending?(invoice)
    invoice.transactions.all? { |transaction| transaction.result == "failed" }
  end

  def merchants_with_only_one_item
    merchants = items.group_by {|item| item.merchant}
    merchants.keys.find_all { |merchant| merchants[merchant].count == 1}
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_by_registration_month[month].find_all do |merchant|
      merchant.items.count == 1
    end
  end

  def merchants_by_registration_month
    merchants.group_by do |merchant|
      Date::MONTHNAMES[merchant.created_at.month]
    end
  end

  def revenue_by_merchant(merchant_id)
    merchant = sales_engine.merchants.find_by_id(merchant_id)
    invoices_total(merchant.invoices).round(2)
  end

  def most_sold_item_for_merchant(merchant_id)
    items_and_count  = item_quantities_of_merchant(merchant_id)
    max              = items_and_count.values.max
    items            = items_and_count.keys
    items.find_all { |item| items_and_count[item] == max }
  end

  def item_quantities_of_merchant(merchant_id)
    invoices = complete_invoices(sales_engine.find_invoices(merchant_id))
    all_invoice_items(invoices).reduce ({}) do |result, invoice_item|
      result[invoice_item.item]  = 0 unless result[invoice_item.item_id]
      result[invoice_item.item] += invoice_item.quantity
      result
    end
  end

  def all_invoice_items(invoices)
    invoices.map { |invoice| invoice.invoice_items }.flatten
  end

  def complete_invoices(invoices)
    invoices.reject { |invoice| pending?(invoice) }
  end

  def best_item_for_merchant(merchant_id)
    items_and_revenues    = item_revenues_of_merchant(merchant_id)
    items                 = items_and_revenues.keys
    items.max_by { |item| items_and_revenues[item] }
  end

  def item_revenues_of_merchant(merchant_id)
    invoices = complete_invoices(sales_engine.find_invoices(merchant_id))
    all_invoice_items(invoices).reduce ({}) do |result, invoice_item|
      result[invoice_item.item]  = 0 unless result[invoice_item.item_id]
      result[invoice_item.item] += invoice_item.quantity*invoice_item.unit_price
      result
    end
  end

end

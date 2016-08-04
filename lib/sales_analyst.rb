require_relative 'sales_engine'
require_relative 'analyst_math'
require 'pry'

class SalesAnalyst
  attr_reader :engine

  def initialize(sales_engine)
    @engine = sales_engine
  end

  def average_items_per_merchant
    AnalystMath.average(engine.items_per_merchant)
  end

  def average_items_per_merchant_standard_deviation
    AnalystMath.standard_deviation(engine.items_per_merchant)
  end

  def merchants_with_high_item_count
    min_items = AnalystMath.std_devs_out(engine.items_per_merchant)
    engine.merchants_with_item_count_over_n(min_items)
  end

  def average_item_price_for_merchant(id)
    merchant_items = engine.find_all_items_by_merchant_id(id)
    item_prices = merchant_items.map(&:unit_price)
    AnalystMath.average(item_prices)
  end

  def average_average_price_per_merchant
    merchant_averages = engine.all_merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    AnalystMath.average(merchant_averages)
  end

  def golden_items
    item_prices = engine.all_items.map(&:unit_price)
    min_price = AnalystMath.std_devs_out(item_prices, 2)
    engine.items_with_price_over_n(min_price)
  end

  def average_invoices_per_merchant
    AnalystMath.average(engine.invoices_per_merchant)
  end

  def average_invoices_per_merchant_standard_deviation
    AnalystMath.standard_deviation(engine.invoices_per_merchant)
  end

  def top_merchants_by_invoice_count
    min_invoices = AnalystMath.std_devs_out(engine.invoices_per_merchant, 2)
    engine.merchants_with_invoice_count_over_n(min_invoices)
  end

  def bottom_merchants_by_invoice_count
    max_invoices = AnalystMath.std_devs_out(engine.invoices_per_merchant, -2)
    engine.merchants_with_invoice_count_under_n(max_invoices)
  end

  def top_days_by_invoice_count
    invoices_by_weekday = engine.total_invoices_by_weekday
    min_invoices = AnalystMath.std_devs_out(invoices_by_weekday.values)
    invoices_by_weekday.select { |_, num| num > min_invoices }.keys
  end

  def invoice_status(status)
    status_match = engine.find_all_invoices_by_status(status).length
    AnalystMath.percentage(status_match, engine.total_invoices)
  end

  def top_buyers(n = 20)
    cust_totals = engine.all_invoices.reduce(Hash.new(0)) do |result, invoice|
      result[invoice.customer] += invoice.total; result
    end
    n = cust_totals.length if cust_totals.length < n
    cust_totals.sort_by(&:last)[-n..-1].reverse.map(&:first)
  end

  def top_merchant_for_customer(cust_id)
    invoices = engine.find_all_invoices_by_customer_id(cust_id)
    top_merchants = invoices.map do |invoice|
      [engine.find_merchant_by_id(invoice.merchant_id),
       engine.find_total_item_quantity_by_invoice_id(invoice.id)]
    end
    top_merchants.sort_by(&:last).last[0]
  end

  def one_time_buyers
    customer_paid_invoices = engine.all_customers.map do |cust|
      [cust, engine.find_fully_paid_invoices_by_customer_id(cust.id)]
    end
    customer_paid_invoices.select { |_, invs| invs.length == 1 }.map(&:first)
  end

  def items_bought_in_year(cust_id, year)
    invoices = engine.invoices.find_all_by_customer_id(cust_id)
    year_invoices = invoices.select { |inv| inv.created_at.year == year }
    year_invoices.map(&:items).flatten.reverse
  end

  def customers_with_unpaid_invoices
    customer_invoices = engine.all_customers.map { |cus| [cus, cus.invoices] }
    unpaid_customer_invoices = customer_invoices.select do |_, invoices|
      invoices.any? { |invoice| !invoice.is_paid_in_full? }
    end
    unpaid_customer_invoices.map(&:first)
  end

  def best_invoice_by_revenue
    paid = engine.paid_invoices
    invoice_items = paid.map { |invoice| [invoice, invoice.invoice_items] }
    inv_revs = Hash.new(0)
    invoice_items.each do |inv, items|
      inv_revs[inv] += items.map(&:bulk_price).reduce(&:+) || 0
    end
    inv_revs.sort_by(&:last)[-1].first
  end

  def best_invoice_by_quantity
    paid = engine.paid_invoices
    invoice_items = paid.map { |invoice| [invoice, invoice.invoice_items] }
    inv_revs = Hash.new(0)
    invoice_items.each do |inv, items|
      inv_revs[inv] += items.map(&:quantity).reduce(&:+) || 0
    end
    inv_revs.max_by { |_, total| total }.first
  end

  def one_time_buyers_item
    otb_invoices = one_time_buyers.map(&:invoices)
    otb_invoice_items = otb_invoices.flatten.map(&:invoice_items)
    otb_item_ids = otb_invoice_items.map do |invoice_items|
      invoice_items.map(&:item_id)
    end
    item_count = otb_item_ids.flatten.reduce(Hash.new(0)) do |res, id|
      res[id] += 1; res
    end
    favorite_item_id = item_count.sort_by(&:last).last.first
    [engine.items.find_by_id(favorite_item_id)]
  end
end

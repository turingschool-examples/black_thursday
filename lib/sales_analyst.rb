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
    min_items = AnalystMath.std_devs_out(engine.items_per_merchant, 1)
    engine.merchants_with_item_count_over_n(min_items)
  end

  def average_item_price_for_merchant(id)
    item_prices = engine.find_all_items_by_merchant_id(id).map { |i| i.unit_price }
    AnalystMath.average(item_prices)
  end

  def average_average_price_per_merchant
    averages = engine.all_merchants.map { |m| average_item_price_for_merchant(m.id) }
    AnalystMath.average(averages)
  end

  # def average_item_price
  #   item_prices = engine.all_items.map {|i| i.unit_price }
  #   AnalystMath.average(item_prices)
  # end

  # def average_item_price_standard_deviation
  #   item_prices = engine.all_items.map {|i| i.unit_price }
  #   AnalystMath.standard_deviation(item_prices)
  # end

  def golden_items
    item_prices = engine.all_items.map {|i| i.unit_price }
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

  def average_invoices_per_day
    AnalystMath.average(engine.total_invoices_by_weekday.values)
  end

  def average_invoices_per_day_standard_deviation
    AnalystMath.standard_deviation(engine.total_invoices_by_weekday.values)
  end

  def top_days_by_invoice_count
    invoices_by_weekday = engine.total_invoices_by_weekday
    min_invs = AnalystMath.std_devs_out(invoices_by_weekday.values, 1)
    invoices_by_weekday.select { |day, num| num > min_invs }.keys
  end

  def invoice_status(status)
    match = engine.all_invoices.select { |inv| inv.status == status }.length
    (match.to_f / engine.total_invoices * 100).round(2)
  end

  def top_buyers(num_custs = 20)
    customer_totals = Hash.new(0)
    engine.all_invoices.each do |invoice|
      total = invoice.total || 0
      customer_totals[invoice.customer] += total
    end
    customer_totals.sort_by(&:last)[-num_custs..-1].reverse.map(&:first)
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
      [ cust, engine.find_fully_paid_invoices_by_customer_id(cust.id)]
    end
    customer_paid_invoices.select{|c, invs| invs.length == 1 }.map(&:first)
  end

end

require 'bigdecimal'
require_relative 'sales_engine.rb'
require 'pry'

class SalesAnalyst
  attr_reader :engine
  def initialize(engine)
    @engine = engine
  end

  def item_collector
    @item_collector ||= engine.items.all
  end

  def invoice_collector
    @invoice_collector ||= engine.invoices.all
  end

  def merchant_collector
    @merchant_collector ||= engine.merchants.all
  end

  def average_items_per_merchant
    (item_collector.length.to_f / merchant_collector.length).round(2)
  end

  def standard_deviation(mean, data_set)
    squared_distance_sum = data_set.map do |data_point|
      (data_point - mean.to_f.abs)**2
    end.reduce(&:+)
    ((squared_distance_sum / (data_set.length - 1))**0.5).round(2)
  end

  def find_mean(data_set)
    total = data_set.reduce(0.0) do |sum, data_point|
      sum + data_point
    end

    total / data_set.length
  end

  def average_items_per_merchant_standard_deviation
    merchant_item_array = merchant_collector.map do |merchant|
      merchant.items.length
    end
    standard_deviation(average_items_per_merchant, merchant_item_array)
  end

  def merchants_with_high_item_count
    avg_item_std_dev = average_items_per_merchant_standard_deviation

    merchant_collector.map do |merchant|
      merchant if (merchant.items.length - avg_item_std_dev) > avg_item_std_dev
    end.compact
  end

  def average_item_price_for_merchant(merch_id)
    merch_items = engine.merchants.find_by_id(merch_id).items

    return 0 if merch_items.empty? #FLAGGED
    (merch_items.map do |item|
      item.unit_price.truncate(2)
    end.reduce(:+) / merch_items.length).round(2)
  end

  def average_average_price_per_merchant
    (merchant_collector.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end.reduce(&:+) / merchant_collector.length).round(2)
  end

  def golden_items
    mean = average_average_price_per_merchant
    price_stdev = price_standard_deviation

    item_collector.map do |item|
      item if (item.unit_price.truncate - mean) > (2 * price_stdev)
    end.compact
  end

  def price_standard_deviation
    item_prices = item_collector.map(&:unit_price)

    mean = find_mean(item_prices)
    standard_deviation(mean, item_prices)
  end

  def average_invoices_per_merchant
    (invoice_collector.length.to_f / merchant_collector.length).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    merchant_invoices = merchant_collector.map do |merchant|
      merchant.invoices.length
    end
    standard_deviation(average_invoices_per_merchant, merchant_invoices)
  end

  def top_merchants_by_invoice_count
    two_stdev = average_invoices_per_merchant_standard_deviation * 2
    average = average_invoices_per_merchant

    merchant_collector.map do |merchant|
      merchant if merchant.invoices.length > (average + two_stdev)
    end.compact
  end

  def bottom_merchants_by_invoice_count
    two_stdev = average_invoices_per_merchant_standard_deviation * 2
    average = average_invoices_per_merchant

    merchant_collector.map do |merchant|
      merchant if merchant.invoices.length < (average - two_stdev)
    end.compact
  end

  def average_invoices_per_weekday
    (invoice_collector.length / 7.0).round(2)
  end

  def average_invoices_per_weekday_standard_deviation
    standard_deviation(average_invoices_per_weekday, weekday_totals.values)
  end

  def weekday_totals
    invoice_collector.reduce(Hash.new(0)) do |weekdays, invoice|
      weekday = invoice.created_at.strftime('%A')
      weekdays[weekday] += 1
      weekdays
    end
  end

  def top_days_by_invoice_count
    mean = average_invoices_per_weekday

    weekday_totals.each do |key, value|
      if (value - mean) > average_invoices_per_weekday_standard_deviation
        return [] << key
      end
    end
  end

  def invoice_status(status)
    invoice_status_count = engine.invoices.find_all_by_status(status).length

    ((invoice_status_count * 100) / invoice_collector.length.to_f).round(2)
  end

  def date_invoices(date)
    invoice_collector.find_all do |invoice|
      invoice.created_at == date
    end.uniq
  end

  def valid_invoices(invoice_array)
    invoice_array.find_all do |invoice|
      @engine.engine_finds_invoice_transactions_and_evaluates(invoice.id)
    end.uniq
  end

  def convert_to_invoice_items(invoice_array)
    invoice_array.map do |invoice|
      @engine.invoice_items_from_invoice(invoice.id)
    end.flatten
  end

  def merchants_ranked_by_revenue
    @merch_rev_rank ||= merchant_collector.sort_by do |merchant|
      revenue_by_merchant(merchant.id)
    end.reverse
  end

  def total_revenue_by_date(date)
    valid_invoices = valid_invoices(date_invoices(date))
    invoice_items = convert_to_invoice_items(valid_invoices)

    invoice_items.reduce(0) do |sum, invoice_item|
      sum + (invoice_item.unit_price * invoice_item.quantity.to_i)
    end
  end

  def find_merchant_invoices(merchant_id)
    invoice_collector.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def revenue_by_merchant(merchant_id)
    merchant_invoices = find_merchant_invoices(merchant_id)

    merchant_invoices.reduce(0) do |sum, invoice|
      revenue = @engine.engine_finds_paid_invoice_and_evaluates_cost(invoice.id)
      sum += revenue unless revenue.nil?
      sum
    end
  end

  def top_revenue_earners(number = 20)
    merchants_ranked_by_revenue[0..(number - 1)]
  end

  def merchants_with_pending_invoices
    invoices = pending_invoices(@engine.invoices.all)
    invoices.map(&:merchant).uniq
  end

  def merchants_with_only_one_item
    merchant_collector.map do |merchant|
      merchant if merchant.items.length == 1
    end.compact
  end

  def merchants_with_only_one_item_registered_in_month(month)
    month_digit = Date::MONTHNAMES.index(month)
    merch_by_month = find_merchants_by_month_registered(month_digit)

    merch_by_month.map do |merchant|
      merchant if merchant.items.length == 1
    end.compact
  end

  def find_merchants_by_month_registered(month_digit)
    merchant_collector.map do |merchant|
      merchant if merchant.created_at.month == month_digit
    end.compact
  end

  def most_sold_item_for_merchant(merchant_id)
    good_invoice_items = find_good_invoice_items(merchant_id)

    item_quantities = good_invoice_items.group_by do |invoice_item|
      invoice_item.quantity.to_i
    end

    item_quantities[item_quantities.keys.max].map do |invoice_item|
      @engine.items.find_by_id(invoice_item.item_id)
    end
  end

  def pending_invoices(invoice_list)
    invoice_list.map do |invoice|
      invoice if invoice.transactions.all? { |trans| trans.result == 'failed' }
    end.compact
  end

  def invoice_items_collector
    @invoice_items_collector ||= engine.invoice_items.all
  end

  def best_item_for_merchant(merchant_id)
    good_invoice_items = find_good_invoice_items(merchant_id)

    best_invoice_item = good_invoice_items.max_by do |invoice_item|
      invoice_item.unit_price_to_dollars * invoice_item.quantity.to_i
    end

    @engine.items.find_by_id(best_invoice_item.item_id)
  end

  def find_good_invoice_items(merchant_id)
    good_invoices = valid_invoices(find_merchant_invoices(merchant_id))
    convert_to_invoice_items(good_invoices)
  end
end

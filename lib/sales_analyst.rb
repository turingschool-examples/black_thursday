# frozen_string_literal: false

require_relative 'analytic_grouping'
# Responsible for relational database query
class SalesAnalyst
  include AnalyticGrouping
  def initialize(engine)
    @engine        = engine
    @items         = @engine.items
    @merchants     = @engine.merchants
    @invoices      = @engine.invoices
    @transactions  = @engine.transactions
    @invoice_items = @engine.invoice_items
    @customers     = @engine.customers
  end

  def mean(numbers_array)
    (numbers_array.inject(:+).to_f / numbers_array.count).round(2)
  end

  def summed_variance(numbers_array)
    avg = mean(numbers_array)
    numbers_array.map do |count|
      (count - avg)**2
    end.inject(:+)
  end

  def standard_deviation(numbers_array)
    result = (summed_variance(numbers_array) / (numbers_array.count - 1))
    Math.sqrt(result).round(2)
  end

  def average_items_per_merchant
    mean(item_count_for_each_merchant_id.values)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(item_count_for_each_merchant_id.values)
  end

  def one_deviation
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def item_count_for_each_merchant_id
    grouped_items = items_group_by_merchant_id
    grouped_items.merge(grouped_items) do |_, item_list|
      item_list.count
    end
  end

  def merchants_with_high_item_count
    item_count_for_each_merchant_id.map do |merchant_id, item_count|
      @merchants.find_by_id(merchant_id) if item_count > one_deviation
    end.compact
  end

  def average_item_price_for_merchant(merchant_id)
    prices = items_group_by_merchant_id[merchant_id].map(&:unit_price)
    BigDecimal(mean(prices), 6)
  end

  def average_average_price_per_merchant
    avg_prices = items_group_by_merchant_id.map do |merchant_id, _|
      average_item_price_for_merchant(merchant_id)
    end
    BigDecimal(mean(avg_prices), 6)
  end

  def all_item_unit_prices
    @items.all.map(&:unit_price)
  end

  def average_item_unit_price
    mean(all_item_unit_prices)
  end

  def average_item_unit_price_standard_deviation
    standard_deviation(all_item_unit_prices)
  end

  def golden_items
    std_dev = average_item_unit_price +
              (average_item_unit_price_standard_deviation * 2)
    @items.all.find_all do |item|
      item.unit_price > std_dev
    end
  end

  def invoice_count_for_each_merchant_id
    grouped_invoices = invoices_group_by_merchant_id
    grouped_invoices.merge(grouped_invoices) do |_, invoice_list|
      invoice_list.count
    end
  end

  def average_invoices_per_merchant
    mean(invoice_count_for_each_merchant_id.values)
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(invoice_count_for_each_merchant_id.values)
  end

  def top_merchants_by_invoice_count
    std_dev = average_invoices_per_merchant +
              (average_invoices_per_merchant_standard_deviation * 2)
    invoice_count_for_each_merchant_id.map do |merchant_id, invoice_count|
      @merchants.find_by_id(merchant_id) if invoice_count > std_dev
    end.compact
  end

  def bottom_merchants_by_invoice_count
    std_dev = average_invoices_per_merchant -
              (average_invoices_per_merchant_standard_deviation * 2)
    invoice_count_for_each_merchant_id.map do |merchant_id, invoice_count|
      @merchants.find_by_id(merchant_id) if invoice_count < std_dev
    end.compact
  end

  def invoices_group_by_day
    @invoices.all.group_by do |invoice|
      invoice.created_at.wday
    end
  end

  def invoice_count_by_weekday
    invoices_group_by_day.map do |day, invoices|
      if day == 0
        ['Sunday', invoices.count]
      elsif day == 1
        ['Monday', invoices.count]
      elsif day == 2
        ['Tuesday', invoices.count]
      elsif day == 3
        ['Wednesday', invoices.count]
      elsif day == 4
        ['Thursday', invoices.count]
      elsif day == 5
        ['Friday', invoices.count]
      elsif day == 6
        ['Saturday', invoices.count]
      end
    end.to_h
  end

  def average_invoice_count_per_weekday
    mean(invoice_count_by_weekday.values)
  end

  def average_invoice_count_per_weekday_standard_deviation
    standard_deviation(invoice_count_by_weekday.values)
  end

  def weekday_deviation
    average_invoice_count_per_weekday +
      average_invoice_count_per_weekday_standard_deviation
  end

  def top_days_by_invoice_count
    invoice_count_by_weekday.map do |day, count|
      day if count > weekday_deviation
    end.compact
  end

  def percentage(numbers)
    (100 * numbers.count / @invoices.all.count.to_f).round(2)
  end

  def invoice_count_by_status
    invoices_group_by_status.map do |status, invoices|
      [status, percentage(invoices)]
    end.to_h
  end

  def invoice_status(status)
    invoice_count_by_status[status]
  end

  def transactions_group_by_invoice_id
    @transactions_group_by_invoice_id ||=
      @transactions.all.group_by(&:invoice_id)
  end

  def invoice_paid_in_full?(invoice_id)
    return false if transactions_group_by_invoice_id[invoice_id].nil?
    transactions_group_by_invoice_id[invoice_id].any? do |transaction|
      transaction.result == :success
    end
  end

  def invoice_total(invoice_id)
    invoice_items_group_by_invoice_id[invoice_id].map do |invoice_item|
      invoice_item.quantity * invoice_item.unit_price
    end.inject(:+)
  end

  def total_spend_per_customer
    invoices_group_by_customer_id.map do |customer_id, invoices|
      spend = invoices.map do |invoice|
        invoice_total(invoice.id) if invoice_paid_in_full?(invoice.id)
      end.compact.inject(:+)
      if spend.nil?
        [customer_id, 0]
      else
        [customer_id, spend]
      end
    end
  end

  def top_buyer_ids(buyers)
    total_spend_per_customer.max_by(buyers) { |_, spend| spend }
  end

  def top_buyers(buyers = 20)
    top_buyer_ids(buyers).map do |customer_id, _|
      @customers.find_by_id(customer_id)
    end
  end

  def invoice_item_qty_per_invoice(invoice_id)
    invoice_items_group_by_invoice_id[invoice_id].map do |invoice_item|
      invoice_item.quantity
    end.inject(:+)
  end

  def invoices_by_customer_by_merchant(customer_id)
    invoices_group_by_customer_id[customer_id].group_by(&:merchant_id)
  end

  def total_items_per_merchant_per_customer(customer_id)
    invoices_by_customer_by_merchant(customer_id).map do |_, invoices|
      invoices.map do |invoice|
        if invoice_item_qty_per_invoice(invoice.id).nil?
          [invoice.merchant_id, 0]
        else
          [invoice.merchant_id, invoice_item_qty_per_invoice(invoice.id)]
        end
      end.first
    end
  end

  def top_merchant_id(customer_id)
    total_items_per_merchant_per_customer(customer_id).max_by do |quantity|
      quantity[1]
    end
  end

  def top_merchant_for_customer(customer_id)
    @merchants.find_by_id(top_merchant_id(customer_id)[0])
  end

  def one_invoice_customer_ids
    invoices_group_by_customer_id.map do |customer_id, invoice_list|
      customer_id if invoice_list.count == 1
    end.compact
  end

  def one_time_buyers
    customers = one_invoice_customer_ids.map do |customer_id|
      @customers.find_by_id(customer_id)
    end
    customers
  end

  def one_time_invoice_ids
    all_invoice_ids = one_invoice_customer_ids.map do |customer_id|
      invoices_group_by_customer_id[customer_id][0].id
    end
    all_invoice_ids
  end

  def one_time_buyers_invoice_items
    all_invoice_items = one_time_invoice_ids.map do |invoice_id|
      invoice_items_group_by_invoice_id[invoice_id]
    end
    all_invoice_items.flatten
  end

  def one_time_item_count
    item_count = Hash.new(0)
    one_time_buyers_invoice_items.each do |invoice_item|
      if invoice_paid_in_full?(invoice_item.invoice_id)
        item_count[invoice_item.item_id] += invoice_item.quantity
      end
    end
    item_count
  end

  def one_time_buyers_top_item
    max_item_id = one_time_item_count.max_by do |_, value|
      value
    end
    @items.find_by_id(max_item_id[0])
  end

  def invoices_bought_in_year(customer_id, year)
    invoices_group_by_customer_id[customer_id].map do |invoice|
      invoice if invoice.created_at.year == year
    end.compact
  end

  def invoice_items_bought_in_year(all_invoices)
    all_invoices.map do |invoice|
      invoice_items_group_by_invoice_id[invoice.id]
    end.flatten
  end

  def items_bought_in_year(customer_id, year)
    all_invoices = invoices_bought_in_year(customer_id, year)
    all_invoice_items = invoice_items_bought_in_year(all_invoices)
    all_items = all_invoice_items.map do |invoice_item|
      @items.find_by_id(invoice_item.item_id)
    end.flatten
    all_items
  end

  def customer_invoice_items(customer_id)
    invoices_group_by_customer_id[customer_id].map do |invoice|
      invoice_items_group_by_invoice_id[invoice.id]
    end.compact.flatten
  end

  def customer_item_count(all_invoice_items)
    item_count = Hash.new(0)
    all_invoice_items.map do |invoice_item|
      item_count[invoice_item.item_id] += invoice_item.quantity
    end
    item_count
  end

  def highest_volume_items(customer_id)
    all_invoice_items = customer_invoice_items(customer_id)
    all_item_count = customer_item_count(all_invoice_items)
    highest_count = all_item_count.max_by do |_, count|
      count
    end
    highest_count = highest_count[1]
    highest_count_item_ids = all_item_count.find_all do |_, count|
      count == highest_count
    end
    all_items = highest_count_item_ids.map do |item_id, _|
      @items.find_by_id(item_id)
    end
    all_items
  end

  def customer_ids_unpaid
    invoices_group_by_customer_id.map do |customer_id, invoice_list|
      customer_id if invoice_list.any? do |invoice|
        !invoice_paid_in_full?(invoice.id)
      end
    end.compact
  end

  def customers_with_unpaid_invoices
    customer_ids_unpaid.map do |customer_id|
      @customers.find_by_id(customer_id)
    end
  end

  def invoice_ids_by_total
    invoice_items_group_by_invoice_id.map do |invoice_id, _|
      if invoice_paid_in_full?(invoice_id)
        [invoice_id, invoice_total(invoice_id)]
      end
    end.compact
  end

  def best_invoice_by_revenue
    best = invoice_ids_by_total.max_by { |_, total| total }
    @invoices.find_by_id(best.first)
  end

  def invoice_ids_by_quantity
    invoice_items_group_by_invoice_id.map do |invoice_id, invoice_items|
      if invoice_paid_in_full?(invoice_id)
        invoice_item_total_quantity = invoice_items.map do |invoice_item|
          invoice_item.quantity
        end.inject(:+)
        [invoice_id, invoice_item_total_quantity]
      end
    end.compact
  end

  def best_invoice_by_quantity
    best = invoice_ids_by_quantity.max_by { |_, quantity| quantity }
    @invoices.find_by_id(best.first)
  end
end

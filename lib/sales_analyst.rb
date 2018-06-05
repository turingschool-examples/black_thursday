# frozen_string_literal: false

require 'pry'
# responsible for database query
class SalesAnalyst

  def initialize(engine)
    @engine = engine
    @items = @engine.items
    @merchants = @engine.merchants
    @invoices = @engine.invoices
    @transactions = @engine.transactions
    @invoice_items = @engine.invoice_items
    @customers = @engine.customers
  end

  def mean(numbers_array) # HELPER
    (numbers_array.inject(:+).to_f / numbers_array.count).round(2)
  end

  def summed_variance(numbers_array) # HELPER
    avg = mean(numbers_array)
    numbers_array.map do |count|
      (count - avg)**2
    end.inject(:+)
  end

  def standard_deviation(numbers_array) # HELPER
    result = (summed_variance(numbers_array) / (numbers_array.count - 1))
    Math.sqrt(result).round(2)
  end

###############################################################
#item analytics

  def average_items_per_merchant # req
    mean(item_count_for_each_merchant_id.values)
  end

  def average_items_per_merchant_standard_deviation # req
    standard_deviation(item_count_for_each_merchant_id.values)
  end

  def one_deviation # HELPER
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def item_count_for_each_merchant_id # HELPER
    grouped_items = items_group_by_merchant_id
    grouped_items.merge(grouped_items) do |_, item_list|
      item_list.count
    end
  end

  def merchants_with_high_item_count #req
    item_count_for_each_merchant_id.map do |merchant_id, item_count|
      @merchants.find_by_id(merchant_id) if item_count > one_deviation
    end.compact
  end

  def items_group_by_merchant_id # HELPER
    @items.all.group_by(&:merchant_id)
  end

  def average_item_price_for_merchant(merchant_id) #req
    prices = items_group_by_merchant_id[merchant_id].map(&:unit_price)
    BigDecimal(mean(prices), 6)
  end

  def average_average_price_per_merchant #req
    avg_prices = items_group_by_merchant_id.map do |merchant_id, _|
      average_item_price_for_merchant(merchant_id)
    end
    BigDecimal(mean(avg_prices), 6)
  end

  def all_item_unit_prices # HELPER
    @items.all.map(&:unit_price)
  end

  def average_item_unit_price # HELPER
    mean(all_item_unit_prices)
  end

  def average_item_unit_price_standard_deviation # HELPER
    standard_deviation(all_item_unit_prices)
  end

  def golden_deviation # HELPER
    average_item_unit_price +
    (average_item_unit_price_standard_deviation * 2)
  end

  def golden_items #req
    @items.all.find_all do |item|
      item.unit_price > golden_deviation
    end
  end

###############################################################
#invoice analytics

  def invoices_group_by_merchant_id # HELPER
    @invoices.all.group_by(&:merchant_id)
  end

  def invoice_count_for_each_merchant_id # HELPER
    grouped_invoices = invoices_group_by_merchant_id
    grouped_invoices.merge(grouped_invoices) do |_ , invoice_list|
      invoice_list.count
    end
  end

  def average_invoices_per_merchant #req
    mean(invoice_count_for_each_merchant_id.values)
  end

  def average_invoices_per_merchant_standard_deviation #req
    standard_deviation(invoice_count_for_each_merchant_id.values)
  end

  def double_deviation # HELPER
    average_invoices_per_merchant +
    (average_invoices_per_merchant_standard_deviation * 2)
  end

  def top_merchants_by_invoice_count # req
    invoice_count_for_each_merchant_id.map do |merchant_id, invoice_count|
      @merchants.find_by_id(merchant_id) if invoice_count > double_deviation
    end.compact
  end

  def bottom_merchants_by_invoice_count # req
    invoice_count_for_each_merchant_id.map do |merchant_id, invoice_count|
      @merchants.find_by_id(merchant_id) if invoice_count < double_deviation
    end.compact
  end

  def invoices_group_by_day # HELPER
    @invoices.all.group_by do |invoice|
      invoice.created_at.wday
    end
  end

  def invoice_count_by_weekday # HELPER
    invoices_group_by_day.map do |day, invoices|
      if day.zero?
        day, invoices = 'Sunday', invoices.count
      elsif day == 1
        day, invoices = 'Monday', invoices.count
      elsif day == 2
        day, invoices = 'Tuesday', invoices.count
      elsif day == 3
        day, invoices = 'Wednesday', invoices.count
      elsif day == 4
        day, invoices = 'Thursday', invoices.count
      elsif day == 5
        day, invoices = 'Friday', invoices.count
      elsif day == 6
        day, invoices = 'Saturday', invoices.count
      end
    end.to_h
  end

  def average_invoice_count_per_weekday # HELPER
    mean(invoice_count_by_weekday.values)
  end

  def average_invoice_count_per_weekday_standard_deviation # HELPER
    standard_deviation(invoice_count_by_weekday.values)
  end

  def weekday_deviation # HELPER
    average_invoice_count_per_weekday +
    average_invoice_count_per_weekday_standard_deviation
  end

  def top_days_by_invoice_count # req
    invoice_count_by_weekday.map do |day, count|
      day if count > weekday_deviation
    end.compact
  end

  def invoices_group_by_status # HELPER
    @invoices.all.group_by(&:status)
  end

  def percentage(numbers) # HELPER
    (100 * numbers.count / @invoices.all.count.to_f).round(2)
  end

  def invoice_count_by_status # HELPER
    invoices_group_by_status.map do |status, invoices|
      status, invoices = status, percentage(invoices)
    end.to_h
  end

  def invoice_status(status) # req
    invoice_count_by_status[status]
  end

  ###############################################################
  #invoice items analytics

  def transactions_group_by_invoice_id # HELPER
    @transactions.all.group_by(&:invoice_id)
  end

  def invoice_paid_in_full?(invoice_id) # req
    return false if transactions_group_by_invoice_id[invoice_id].nil?
    transactions_group_by_invoice_id[invoice_id].any? do |transaction|
      transaction.result == :success
    end
  end

  def invoice_items_group_by_invoice # HELPER
    @invoice_items.all.group_by(&:invoice_id)
  end

  def invoice_total(invoice_id) # req
    invoice_items_group_by_invoice[invoice_id].map do |invoice_item|
      invoice_item.quantity * invoice_item.unit_price
    end.inject(:+)
  end

###############################################################
#customer analytics

  def invoices_group_by_customer_id # HELPER
    @invoices.all.group_by(&:customer_id)
  end

  def total_spend_per_customer #HELPER
    invoices_group_by_customer_id.map do |customer, invoices|
      spend = invoices.map do |invoice|
        invoice_total(invoice.id) if invoice_paid_in_full?(invoice.id)
      end.compact.inject(:+)
      if spend.nil?
        [customer, 0]
      else
        [customer, spend]
      end
    end
  end

  def top_buyers(x = 20) # req
    total_spend_per_customer.sort_by do |customer_id, spend|
      spend
    end.reverse[0..x - 1].map do |customer_id, _|
      @customers.find_by_id(customer_id)
    end
  end

  def invoice_item_qty_per_invoice(invoice_id) # HELPER
    invoice_items_group_by_invoice[invoice_id].map do |invoice_item|
      invoice_item.quantity
    end.inject(:+)
  end

  def total_items_per_merchant_per_customer(customer_id) # HELPER
    my_merchants =
      invoices_group_by_customer_id[customer_id].group_by(&:merchant_id)
    my_merchants.map do |_, invoices|
      invoices.map do |invoice|
        if invoice_item_qty_per_invoice(invoice.id).nil?
          [invoice.merchant_id, 0]
        else
          [invoice.merchant_id, invoice_item_qty_per_invoice(invoice.id)]
        end
      end[0]
    end
  end

  def top_merchant_id(customer_id) # HELPER
    total_items_per_merchant_per_customer(customer_id).max_by do |quantity|
      quantity[1]
    end
  end

  def top_merchant_for_customer(customer_id) # req
    @merchants.find_by_id(top_merchant_id(customer_id)[0])
  end

  def one_invoice_customer_ids # HELPER
    invoices_group_by_customer_id.map do |customer_id, invoice_list|
      customer_id if invoice_list.count == 1
    end.compact
  end

  def one_time_buyers # req
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
      invoice_items_group_by_invoice[invoice_id]
    end
    return all_invoice_items.flatten
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

  def one_time_buyers_top_item #req
    max_item_id = one_time_item_count.max_by do |_,value|
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
      invoice_items_group_by_invoice[invoice.id]
    end.flatten
  end

  def items_bought_in_year(customer_id, year) # req
    all_invoices = invoices_bought_in_year(customer_id, year)
    all_invoice_items = invoice_items_bought_in_year(all_invoices)
    all_items = all_invoice_items.map do |invoice_item|
      @items.find_by_id(invoice_item.item_id)
    end.flatten
    return all_items
  end

  def customer_invoice_items(customer_id)
    invoices_group_by_customer_id[customer_id].map do |invoice|
      invoice_items_group_by_invoice[invoice.id]
    end.compact.flatten
  end

  def customer_item_count(all_invoice_items)
    item_count = Hash.new(0)
    all_invoice_items.map do |invoice_item|
      item_count[invoice_item.item_id] += invoice_item.quantity
    end
    item_count
  end

  def highest_volume_items(customer_id) # req
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

  def customers_with_unpaid_invoices # req
    customers = customer_ids_unpaid.map do |customer_id|
      @customers.find_by_id(customer_id)
    end
  end

  def invoice_ids_by_total
    @invoices.all.map do |invoice|
      if invoice_paid_in_full?(invoice.id)
        [invoice.id, invoice_total(invoice.id)]
      end
    end.compact
  end

  def best_invoice_by_revenue
    best = invoice_ids_by_total.max_by { |_, total| total }
    @invoices.find_by_id(best.first)
  end
end


# REMAINING METHODS NEEDED
  # def best_invoice_by_quantity # req
  # end

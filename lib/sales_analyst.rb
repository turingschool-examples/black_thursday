# frozen_string_literal: true

require_relative 'require_store'

class SalesAnalyst
  include Calculation
  include Find
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :customers,
              :transactions

  def initialize(engine)
    @items = engine.items
    @merchants = engine.merchants
    @invoices = engine.invoices
    @invoice_items = engine.invoice_items
    @customers = engine.customers
    @transactions = engine.transactions
  end

  def merchants_with_high_item_count
    grouped_by_merchant_id(items).filter_map do |merchant, items|
      next if items - average_items_per_merchant_standard_deviation < average_items_per_merchant

      merchants.find_by_id(merchant)
    end
  end

  def golden_items
    min = avg_price_per_item + (average_item_price_standard_deviation * 2)
    max = 99_999
    items.find_all_by_price_in_range(min..max)
  end

  def invoice_status(status)
    total_by_status = invoices.find_all_by_status(status)
    ((total_by_status.length.to_f / invoices.all.length) * 100).round(2)
  end

  def top_merchants_by_invoice_count
    merchants_by_invoice_count('top')
  end

  def bottom_merchants_by_invoice_count
    merchants_by_invoice_count('bottom')
  end

  def top_days_by_invoice_count
    day_hash.filter_map do |day, amount|
      day if amount > (average_invoices_per_day + average_invoices_per_day_standard_deviation)
    end
  end

  def invoice_paid_in_full?(invoice)
    transactions_in_invoice = transactions.find_all_by_invoice_id(invoice)
    transactions_in_invoice.any? { |transaction| transaction.result == :success }
  end

  def invoice_total(invoice)
    if !invoice_paid_in_full?(invoice)
      0
    else
      invoice_items_specific = invoice_items.find_all_by_invoice_id(invoice)
      invoice_items_specific.sum { |ii| ii.unit_price * ii.quantity }.round(2)
    end
  end

  def total_revenue_by_date(date_input)
    invoice_by_day = invoices.all.find_all do |invoice|
      date_input.strftime('%D') == invoice.created_at.strftime('%D')
    end

    invoice_by_day.sum { |invoice| invoice_total(invoice.id) }
  end

  def top_revenue_earners(top_earners = 20)
    sorted_merchants = merchants.all.sort_by do |merchant|
      revenue_by_merchant(merchant.id)
    end
    sorted_merchants.reverse.first(top_earners)
  end

  def merchants_with_only_one_item
    merchants.all.find_all do |merchant|
      items.find_all_by_merchant_id(merchant.id).length <= 1
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_by_month_created = merchants_with_only_one_item.group_by do |merchant|
      merchant.created_at.strftime('%B').downcase
    end
    merchants_by_month_created[month.downcase]
  end

  def items_for_specific_merchant(merchant_id)
    specific_merchant_invoices = invoices.find_all_by_merchant_id(merchant_id)
    specific_invoice_items = specific_merchant_invoices.flat_map do |invoice|
      invoice_items.find_all_by_invoice_id(invoice.id)
    end
    specific_invoice_items.group_by(&:item_id)
  end

  def most_sold_item_for_merchant(merchant_id)
    hash = items_for_specific_merchant(merchant_id)
    hash.map do |item_id, invoice_items|
      hash[item_id] = invoice_items.sum(&:quantity)
    end
    top_item_id = hash.filter_map { |item_id, total_items| item_id if total_items == hash.values.max }
    top_item_id.map { |item| items.find_by_id(item) }
  end

  def best_item_for_merchant(merchant_id)
    hash = items_for_specific_merchant(merchant_id)
    hash.map do |item_id, invoice_items|
      hash[item_id] = invoice_items.sum do |invoice_item|
        invoice_item.quantity * invoice_item.unit_price
      end
    end
    items.find_by_id(hash.key(hash.values.max))
  end

  def merchants_with_pending_invoices
    pend_invoices = invoices.all.find_all do |invoice|
      !invoice_paid_in_full?(invoice.id)
    end
    merch_ids = pend_invoices.map(&:merchant_id)
    merch_ids.map do |id|
      merchants.find_by_id(id)
    end.uniq
  end

  def invoices_by_customer
    invoices.all.group_by(&:customer_id)
  end

  def one_time_buyers
    invoices_by_customer.filter_map do |customer, invoices|
      customers.find_by_id(customer) if invoices.length == 1
    end
  end

  def one_time_buyers_item
    one_time = invoices_by_customer.delete_if { |customer, invoices| invoices.length > 1}
    one_time_invoice_items = one_time.values.flatten.map { |invoice| invoice_items.find_all_by_invoice_id(invoice.id)}
    grouped = one_time_invoice_items.flatten.group_by(&:item_id)
    grouped.map do |item_id, invoice_items|
      grouped[item_id] = invoice_items.sum(&:quantity)
    end
    grouped.filter_map { |item_id, quantity| items.find_by_id(item_id) if quantity == grouped.values.max}
  end

  def top_buyers(top_buyers = 20)
    sorted_customers = customers.all.sort_by do |customer|
      spending_by_customer(customer.id)
    end
    sorted_customers.reverse.first(top_buyers)
  end

  def customers_with_unpaid_invoices
    unpaid_invoices = invoices.all.find_all do |invoice|
      !invoice_paid_in_full(invoice.id)
    end
    cust_ids = unpaid_invoices.map(&:customer_id)
    cust_ids.map do |id|
      customers.find_by_id(id)
    end.uniq
  end
end

require "pry"

require_relative 'statistics'
require_relative 'finders'
require_relative 'customer_intelligence'
require_relative 'merchant_intelligence'
require_relative 'invoice_intelligence'
require 'date'

class SalesAnalyst
  include Statistics
  include Finders
  include CustomerIntelligence
  include MerchantIntelligence
  include InvoiceIntelligence

  attr_reader :items, :merchants, :invoices, :invoice_items, :customers, :transactions

  def initialize(items, merchants, invoices, invoice_items, customers, transactions)
    @items = items
    @merchants = merchants
    @invoices = invoices
    @invoice_items = invoice_items
    @customers = customers
    @transactions = transactions
  end

  def golden_items
    item_prices = @items.all.map(&:unit_price)
    item_prices_std_dev = standard_deviation(*item_prices)
    average_item_price = average(*item_prices)
    @items.all.select do |item|
      item.unit_price > average_item_price + item_prices_std_dev * 2
    end
  end

  def days_with_count
    days = %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)
    days.map{|day| [day, each_invoice_day.count(day)]}.to_h
  end

  def total_revenue_by_date(date)
    revenue_from_invoices(@invoices.find_all_by_date(date))
  end

  def get_top_invoice_items_for(invoice, multiple = true)
    top_quantity = find_top_quantity_from(invoice)
    top_items = find_from_invoice(invoice, 'InvoiceItem').find_all do |invoice_item|
      invoice_item.quantity == top_quantity
    end
    multiple ? top_items : top_items.first
  end

  def find_highest_transaction_count_from(one_time_customers)
    one_time_customers.reduce(0) do |highest, customer|
      invoice = find_invoices_from(customer)[0]
      next highest unless all_transactions_successful_for?(invoice.id)
      top_item = get_top_invoice_items_for(invoice, false)
      current = get_transaction_count_for(top_item)
      highest = current if current > highest
      highest
    end
  end

  def find_highest_quantity_for(all_invoices)
    if all_invoices.class == Array
      all_invoice_items = all_invoices.reduce([]) do |inv_items, invoice|
        inv_items << invoice_items.find_all_by_invoice_id(invoice.id)
        inv_items.flatten
      end
    else
      all_invoice_items = invoice_items.find_all_by_invoice_id(all_invoices.id)
    end

    all_invoice_items.reduce(0) do |top_quantity, invoice_item|
      current = invoice_item.quantity
      top_quantity = current if current > top_quantity
      top_quantity
    end
  end

  def get_transaction_count_for(invoice_item)
    transactions.find_all_by_invoice_id(invoice_item.invoice_id).count
  end
end

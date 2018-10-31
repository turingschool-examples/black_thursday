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

  

  def total_revenue_by_date(date)
    revenue_from_invoices(@invoices.find_all_by_date(date))
  end

  def get_top_invoice_item_for(invoice_id)
    all_items = invoice_items.find_all_by_invoice_id(invoice_id)
    top_invoice_item = nil
    all_items.reduce(0) do |top_quantity, invoice_item|
      current_quantity = invoice_item.quantity
      if current_quantity > top_quantity
        top_quantity = current_quantity
        top_invoice_item = invoice_item
      end
      top_quantity
    end
    top_invoice_item
  end

  def get_top_invoice_items_for(invoice_id)
    top_quantity = find_highest_quantity_for(invoices.find_by_id(invoice_id))
    all_items = invoice_items.find_all_by_invoice_id(invoice_id)
    top_invoice_items = all_items.reduce([]) do |top_items, invoice_item|
      current_quantity = invoice_item.quantity
      top_items << invoice_item if current_quantity >= top_quantity
      top_items
    end
    top_invoice_items
  end

  def find_highest_transaction_count_for(top_invoice_items)
    top_invoice_items.reduce(0) do |highest, invoice_item|
      current = get_transaction_count_for(invoice_item)
      highest = current if current >= highest
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

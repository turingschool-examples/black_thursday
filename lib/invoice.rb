require 'csv'
require 'time'
require_relative 'unit_price'

class Invoice
  include UnitPrice

  attr_reader :id, :created_at, :updated_at, :merchant_id, :customer_id, :status, :engine

  def initialize(invoice_info, engine)
    @id = invoice_info[:id].to_i
    @customer_id = invoice_info[:customer_id].to_i
    @status = invoice_info[:status].to_sym
    @created_at = Time.parse(invoice_info[:created_at])
    @updated_at = Time.parse(invoice_info[:updated_at])
    @merchant_id = invoice_info[:merchant_id].to_i
    @engine = engine
  end

  def merchant
    @engine.merchants.find_by_id(@merchant_id)
  end

  def find_item_ids(invoice_items_by_invoice_id)
    item_ids = invoice_items_by_invoice_id.map do |invoice_item|
      invoice_item.item_id
    end
  end

  def find_items_from_item_ids(item_ids_from_invoice)
    items = item_ids_from_invoice.map do |item_id|
      @engine.items.find_by_id(item_id)
    end
    items.compact
  end

  def items
    invoice_items = @engine.invoice_items.find_all_by_invoice_id(@id)
    item_ids = find_item_ids(invoice_items)
    find_items_from_item_ids(item_ids)
  end

  def transactions
    @engine.transactions.find_all_by_invoice_id(@id)
  end

  def customer
    @engine.customers.find_by_id(@customer_id)
  end

  def is_paid_in_full?
    transactions.each do |transaction|
      return true if transaction.result == 'success'
    end
    false
  end

  def total
    if is_paid_in_full?
      sales = @engine.invoice_items.find_all_by_invoice_id(@id)
      total = sales.reduce(0) do |result, invoice_item|
        revenue = invoice_item.quantity * invoice_item.unit_price
        result + revenue
      end
    end
  end


end

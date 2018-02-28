require 'csv'
require_relative 'invoice'
require_relative 'repository'

# Repository of Invoices
class InvoiceRepository
  include Repository
  attr_reader :engine,
              :csv_items

  def initialize(filepath, parent = nil)
    @csv_items = []
    @engine   = parent
    load_children(filepath)
  end

  def invoices
    @csv_items
  end

  def child
    Invoice
  end

  def find_all_by_customer_id(id)
    invoices.find_all { |invoice| invoice.customer_id == id }
  end

  def find_all_by_merchant_id(id)
    invoices.find_all { |invoice| invoice.merchant_id == id }
  end

  def find_all_by_status(status)
    invoices.find_all { |invoice| invoice.status == status }
  end

  def find_merchant_by_merchant_id(id)
    engine.find_merchant_by_merchant_id(id)
  end

  def find_invoice_items_by_invoice_id(id)
    engine.find_invoice_items_by_invoice_id(id)
  end

  def find_item_by_id(item_id)
    engine.find_item_by_id(item_id)
  end

  def find_transactions_by_invoice_id(invoice_id)
    engine.find_transactions_by_invoice_id(invoice_id)
  end

  def find_customer_by_customer_id(customer_id)
    engine.find_customer_by_customer_id(customer_id)
  end
end

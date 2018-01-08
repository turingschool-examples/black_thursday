require_relative 'invoice'
require_relative 'sales_engine'
require 'csv'

class InvoiceRepo
  attr_reader :invoices,
              :sales_engine

  def initialize(sales_engine, filename)
    @invoices     = []
    @sales_engine = sales_engine
    load_invoices(filename)
  end

  def load_invoices(filename)
    invoice_csv = CSV.open filename,
                           headers: true,
                           header_converters: :symbol,
                           converters: :numeric
    invoice_csv.each do |row| @invoices << Invoice.new(row, self)
    end
  end

  def all
    invoices
  end

  def find_by_id(id)
    invoices.find { |invoice| invoice.id == id }
  end

  def find_all_by_customer_id(customer_id)
    invoices.find_all { |invoice| invoice.customer_id == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    invoices.find_all { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_all_by_status(status)
    invoices.find_all { |invoice| invoice.status.to_sym == status }
  end

  def find_all_by_created_date(date)
    invoices.find_all { |invoice| invoice.created_at == date }
  end

  def find_merchant_by_id(merchant_id)
    @sales_engine.find_merchant(merchant_id)
  end

  def find_invoice_items_by_invoice_id(id)
    @sales_engine.find_invoice_items_by_invoice_id(id)
  end

  def find_transactions_by_invoice_id(id)
    @sales_engine.find_transactions_by_invoice_id(id)
  end

  def find_customer_by_id(id)
    @sales_engine.find_customer_by_id(id)
  end

  def inspect
    "#<#{self.class} #{invoices.size} rows>"
  end
end

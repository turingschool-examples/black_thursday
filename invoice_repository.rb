require_relative "invoice"
require_relative "sales_engine"
require 'csv'

class InvoiceRepository

  def initialize(value_at_invoice, sales_engine)
    @sales_engine = sales_engine
    make_invoices(value_at_invoice)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def make_invoices(invoice_hashes)
    @invoices = []
    invoice_hashes.each do |invoice_hash|
      @invoices << Invoice.new(invoice_hash, self)
    end
    @invoices
  end

  def all?
    @invoices
  end

  def find_by_id(id)
    @invoices.find { |object| object.id == id }
  end

  def find_all_by_customer_id(id)
    @invoices.find_all { |object| object.customer_id == id}
  end

  def find_all_by_merchant_id(id)
    @invoices.find_all { |object| object.merchant_id == id}
  end

  def find_all_by_status(status)
    @invoices.find_all { |object| object.status == status}
  end

end

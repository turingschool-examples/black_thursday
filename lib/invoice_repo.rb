require 'csv'
require_relative 'invoice'
require 'pry'

class InvoiceRepo
  attr_reader :invoices, :parent

  def initialize(filename, se=nil)
    @invoices = {}
    open_file(filename)
    @parent   = se
  end

  def open_file(filename)
    CSV.foreach filename,  headers: true, header_converters: :symbol do |row|
      invoices[row[:id].to_i] = Invoice.new(row, self)
    end
  end

  def all
    invoices.values
  end

  def find_by_id(id)
    invoices[id]
  end

  def find_all_by_customer_id(cust_id)
    all.find_all {|invoice| invoice.customer_id == cust_id}
  end

  def find_all_by_merchant_id(merch_id)
    all.find_all {|invoice| invoice.merchant_id == merch_id}
  end

  def find_all_by_status(status)
    all.find_all {|invoice| invoice.status == status}
  end

  def merchant_invoice(id)
    parent.merchant_invoice(id)
  end

  def items_from_invoice(id)
    parent.items_from_invoice(id)
  end

  def invoice_transactions(id)
    parent.invoice_transactions(id)
  end

  def customer_invocies(id)
    parent.customer_invocies(id)
  end

  def total(id)
    parent.total(id)
  end


end

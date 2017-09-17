require 'csv'
require_relative 'invoice'
require 'pry'

class InvoiceRepository
  attr_reader :invoices, :sales_engine

  def initialize(invoice_file, sales_engine)
    @invoices = read_invoices_file(invoice_file)
    @sales_engine = sales_engine
  end

  def read_invoices_file(invoice_file)
    invoice_list = []
    CSV.foreach(invoice_file,headers: true,header_converters: :symbol) do |row|
      invoices_info = {}
      invoices_info[:id] = row[:id]
      invoices_info[:customer_id] = row[:customer_id]
      invoices_info[:merchant_id] = row[:merchant_id]
      invoices_info[:status] = row[:status]
      invoices_info[:created_at] = row[:created_at]
      invoices_info[:updated_at] = row[:updated_at]
      invoice_list << Invoice.new(invoices_info, self)
    end
    invoice_list
  end

  def all
    invoices
  end

  def find_by_id(id)
    invoices.find {|invoice| invoice.id == id}
  end

  def find_all_by_customer_id
    invoices.find_all {|invoice| invoice.customer_id == customer_id}
  end

  def find_all_by_merchant_id
    invoices.find_all {|invoice| invoice.merchant_id == merchant_id}
  end

  def find_all_by_status
    invoices.find_all {|invoice| invoice.status == status}
  end

  def find_by_created_at
    invoices.find {|invoice| invoice.created_at == created_at}
  end

  def find_by_updated_at
    invoices.find {|invoice| invoice.updated_at == updated_at}
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

end

require_relative "invoice"
require_relative "sales_engine"
require 'csv'
require 'pry'

class InvoiceRepository
  attr_reader :invoices,
              :sales_engine

  def initialize(parent, filename)
    @invoices            = []
    @sales_engine        = parent
    @load                = load_file(filename)
  end

  def load_file(filename)
    invoice_csv = CSV.open filename,
                             headers: true,
                             header_converters: :symbol
    invoice_csv.each do |invoice| @invoices << Invoice.new(invoice, self) end
  end

  def all
    invoices
  end

  def find_by_id(id)
    # find_by_id - returns either nil or an instance of Invoice with a matching ID
    invoices.find { |invoice| invoice.id == id.to_s }
  end

  def find_all_by_customer_id(customer_id)
    # find_all_by_customer_id - returns either [] or one or more matches which have a matching customer ID
    invoices.find_all { |invoice| invoice.customer_id == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    # find_all_by_merchant_id - returns either [] or one or more matches which have a matching merchant ID
    invoices.find_all { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_all_by_status(status)
    # find_all_by_status - returns either [] or one or more matches which have a matching status
    invoices.find_all { |invoice| invoice.status == status }
  end

  def find_merchant(id)
    @sales_engine.find_merchant(id)
  end

end

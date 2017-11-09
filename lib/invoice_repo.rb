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

  # def all_clean
  #   invoices.find_all do |invoice|
  #     invoice if invoice.is_paid_in_full? == true
  #   end
  # end

  def find_by_id(id)
    invoices.find { |invoice| invoice.id == id }
  end

  def find_all_by_customer_id(customer_id)
    invoices.find_all { |invoice| invoice.customer_id == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    invoices.find_all { |invoice| invoice.merchant_id == merchant_id.to_i }
  end

  def find_all_by_status(status)
    invoices.find_all { |invoice| invoice.status.to_sym == status }
  end

  def find_all_by_created_date(date)
    invoices.find_all do |invoice|
      invoice.created_at == date
    end
  end

  # def format_date(date)
  #   date.strftime("%Y-%m-%d")
  # end

  def find_merchant(id)
    @sales_engine.find_merchant(id)
  end

  def find_items_by_invoice_id(id)
    @sales_engine.find_items_by_invoice_id(id)
  end

  def find_transactions_by_invoice_id(id)
    @sales_engine.find_transactions_by_invoice_id(id)
  end

  def find_customer_by_customer_id(id)
    @sales_engine.find_customer_by_customer_id(id)
  end

  def inspect
      "#<#{self.class} #{@invoices.size} rows>"
  end

  def find_invoice_items_by_invoice_id(id)
    @sales_engine.find_invoice_items_by_invoice_id(id)
  end

end

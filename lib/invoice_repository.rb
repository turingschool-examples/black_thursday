require_relative 'invoice'
# require 'csv'

class InvoiceRepository
  attr_reader :invoices,
              :se

  def initialize(invoice_file_path, se)
    @se = se
    @invoices = []
    contents = CSV.open invoice_file_path,
                 headers: true,
                 header_converters: :symbol
    contents.each do |row|
      id = (row[:id]).to_i
      customer_id = (row[:customer_id]).to_i
      status = (row[:status]).to_sym
      created_at = row[:created_at]
      updated_at = row[:updated_at]
      merchant_id = (row[:merchant_id]).to_i
      invoice = Invoice.new(id, customer_id, status,
                            created_at, updated_at,
                            merchant_id, self)
      @invoices << invoice
    end
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(customer_id)
    @invoices.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @invoices.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    @invoices.find_all do |invoice|
      invoice.status == status
    end
  end

  def fetch_merchant_from_invoice_id(merchant_id)
    se.fetch_merchant_from_invoice_id(merchant_id)
  end

  def fetch_items_from_invoice_id(invoice_id)
    se.fetch_items_from_invoice_id(invoice_id)
  end

  def fetch_transactions_from_invoice_id(invoice_id)
    se.fetch_transactions_from_invoice_id(invoice_id)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

end

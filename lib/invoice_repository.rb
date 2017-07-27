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
      status = row[:status]
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

end
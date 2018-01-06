require 'csv'
require_relative '../lib/invoice'

class InvoiceRepository

  attr_reader :invoices,
              :se

  def initialize(csv_file, se)
    @invoices = []
    CSV.foreach csv_file, headers: true, header_converters: :symbol do |row|
      @invoices << Invoice.new({
        id: row[:id],
        customer_id: row[:customer_id],
        merchant_id: row[:merchant_id],
        status: row[:status],
        created_at: row[:created_at],
        updated_at: row[:updated_at],
        invoice_repo: self
        })
      end
    @se = se
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end


  def all
    @invoices
  end

end

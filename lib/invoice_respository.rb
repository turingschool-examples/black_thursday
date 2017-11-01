require 'csv'
require './lib/invoice'

class InvoiceRepository

  def initialize(invoice_files, parent)
    @invoices      = []
    @invoice_files = invoice_files
    @parent        = parent
  end


  def create_invoice(data)
    CSV.foreach(invoice_file, headers: true, header_converters: :symbol) do |row|
      invoices << Invoice.new(row, self)
    end
  end

end

require 'csv'
require './lib/invoice'

class InvoiceRepository

  def initialize(invoice_file, parent)
    @invoices      = invoice_file.map {|invoice| Invoice.new(invoice, self)}
    @parent        = parent
  end


  def create_invoice(data)
    CSV.foreach(invoice_file, headers: true, header_converters: :symbol) do |row|
      invoices << Invoice.new(row, self)
    end
  end

end

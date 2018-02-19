require_relative 'invoice'

class InvoiceRepository
  attr_reader :parent, :invoices
  def initialize(invoice_csv, parent)
    @parent = parent
    @invoices = []

    csv_file = CSV.open(invoice_csv, headers: true, header_converters: :symbol)
    csv_file.each do |row|
      @invoices << Invoice.new(row, self)
    end
  end
end

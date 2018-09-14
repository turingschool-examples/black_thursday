require 'pry'
require 'CSV'

class InvoiceRepository
  attr_reader     :invoices

  def initialize(invoice_path)
    @invoices = []
    make_invoices(invoice_path)
  end

  def all
    @invoices
  end

  def make_invoices(invoice_path)
   csv_objects = CSV.open(invoice_path, headers: true, header_converters: :symbol)
    csv_objects.map do |row|
      @invoices << InvoiceRepository.new(row)
    end
  end
end

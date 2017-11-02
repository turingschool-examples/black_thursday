require 'csv'

class InvoiceRepository
  attr_reader :invoices,
              :parent

  def initialize(invoices, parent = nil)
    @invoices  = load_csv(invoices).map { |row| Invoice.new(row, self) }
    @parent = parent
  end

  def load_csv(filename)
    CSV.open filename, headers: true, header_converters: :symbol
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find { |invoice| invoice.id == id }
  end
end

require_relative 'invoice'

class InvoiceRepository
  attr_reader :invoice_data, :all, :parent

  def initialize(invoice_data, parent = nil)
    @invoice_data = invoice_data
    @all = invoice_data.map { |row| Invoice.new(row, self) }
    @parent = parent
  end

end

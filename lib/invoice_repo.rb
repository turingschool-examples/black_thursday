require './lib/invoice'
require 'csv'
class InvoiceRepo
  attr_reader :all_invoices, :parent
  def initialize(file, ir = nil)
    @all_invoices = []
    open_file(file)
    # @parent = se
  end

  def open_file(file)
    CSV.foreach file, headers: true, header_converters: :symbol do |row|
      all_invoices << Invoice.new(row, self)
    end
  end

  def find_by_id(invoice_id)
    all_invoices.find { |invoice| invoice.id == invoice_id }
  end

end

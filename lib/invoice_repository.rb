# item_repository
require 'pry'
class InvoiceRepository
  attr_reader :invoices

  def initialize(invoices)
    @invoices = invoices
  end

  def all
    @invoices
  end

  def find_by_id(invoice_id)
    @invoices.find { |invoice| invoice.id == invoice_id }
  end
end

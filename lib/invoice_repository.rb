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

  def find_all_by_customer_id(customer_id)
    @invoices.find_all { |invoice| invoice.customer_id == customer_id }
  end
end

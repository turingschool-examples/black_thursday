require_relative 'invoice'

class InvoiceRepository
  attr_reader   :invoices
  attr_accessor :merchant

  def initialize(invoices_data)
    @invoices = create_invoices(invoices_data)
  end

  def create_invoices(invoices_data)
    invoices_data.map { |invoice| Invoice.new(invoice) }
  end

  def all
    invoices
  end

  def find_by_id(invoice_id)
    invoices.find { |invoice| invoice.id == invoice_id }
  end

  def find_all_by_customer_id(customer_id)
    invoices.find_all { |invoice| invoice.customer_id == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    invoices.find_all { |invoice| invoice.merchant_id == merchant_id.to_i }
  end

  def find_all_by_status(status)
    invoices.find_all { |invoice| invoice.status == status.to_sym }
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

end

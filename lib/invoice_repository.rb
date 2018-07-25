require_relative 'invoice'

class InvoiceRepository
  def initialize(invoice_data)
    @invoice_rows ||= build_invoice(invoice_data)
    @invoices = @invoice_rows
  end

  def build_invoice(invoice_data)
    invoice_data.map do |invoice|
      Invoice.new(invoice)
    end
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find do |invoice|
      invoice.id == id
    end
  end
end

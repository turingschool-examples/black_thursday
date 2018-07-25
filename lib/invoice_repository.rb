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

  def find_all_by_customer_id(customer_id)
    @invoices.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @invoices.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    @invoices.find_all do |invoice|
      invoice.status == status
    end
  end
end

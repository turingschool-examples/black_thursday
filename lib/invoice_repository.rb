require_relative 'invoice'

class InvoiceRepository
  attr_reader :invoices, :parent

  def initialize(invoice_contents, parent = nil)
    @invoices = make_invocies(invoice_contents)
    @parent = parent
  end

  def make_invocies(invoice_contents)
    invoice_contents.map { |row| Invoice.new(row, self) }
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find { |invoice| invoice.id == id }
  end

  def find_all_by_customer_id(customer_id)
    @invoices.find_all { |invoice| invoice.customer_id == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    @invoices.find_all { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_all_by_status(status)
    @invoices.find_all do
      |invoice| invoice.status == status
    end
  end

  def find_merchant_by_id(merchant_id)
    parent.find_merchant_by_id(merchant_id)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end
end

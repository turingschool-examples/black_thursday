require_relative 'invoice'

class InvoiceRepository
  attr_reader :invoices, :parent

  def initialize(invoice_contents, parent = nil)
    @invoices = make_invoices(invoice_contents)
    @parent = parent
  end

  def make_invoices(invoice_contents)
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
    @invoices.find_all { |invoice| invoice.status == status }
  end

  def find_merchant_by_id(merchant_id)
    parent.find_merchant_by_id(merchant_id)
  end

  def find_all_merchants_by_customer_id(c_id)
    invoices = find_all_by_customer_id(c_id)
    invoices.map(&:merchant)
  end

  def find_items_by_id(invoice_id)
    @parent.find_items_by_invoice_id(invoice_id)
  end

  def find_invoice_items_by_id(invoice_id)
    @parent.find_invoice_items_by_invoice_id(invoice_id)
  end

  def find_items_by_merchant_id(merchant_id)
    @parent.find_all_items_by_merchant_id(merchant_id)
  end

  def find_transactions_by_id(invoice_id)
    @parent.find_transactions_by_invoice_id(invoice_id)
  end

  def find_customer_by_id(customer_id)
    @parent.find_customer_by_id(customer_id)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end
end

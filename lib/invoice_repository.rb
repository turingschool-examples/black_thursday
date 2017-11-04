require_relative './invoice'

class InvoiceRepository
  attr_reader :invoices, :parent

  def initialize(invoices, parent)
    @invoices = invoices.map {|invoice| Invoice.new(invoice, self)}
    @parent = parent
  end

  def all
    invoices
  end

  def find_by_id(id)
    invoices.find do |invoice|
      invoice.id == id.to_i
    end
  end

  def find_all_by_customer_id(customer_id)
    invoices.find_all do |invoice|
      invoice.customer_id == customer_id.to_i
    end
  end

  def find_all_by_merchant_id(merchant_id)
    invoices.find_all do |invoice|
      invoice.merchant_id == merchant_id.to_i
    end
  end

  def find_all_by_status(status)
    invoices.find_all do |invoice|
      invoice.status == status.downcase.to_sym
    end
  end

  def find_merchant_by_id(merchant_id)
    parent.find_merchant_by_id(merchant_id)
  end

  def find_invoice_items_by_invoice_id(invoice_id)
    parent.find_invoice_items_by_invoice_id(invoice_id)
  end

  def find_transaction_by_invoice_id(invoice_id)
    parent.find_transaction_by_invoice_id(invoice_id)
  end

  def find_customer_by_id(customer_id)
    parent.find_customer_by_id(customer_id)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end
end

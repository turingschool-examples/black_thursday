require_relative './invoice'

class InvoiceRepo
  def initialize(sales_engine = nil)
    @invoices = []
    @sales_engine = sales_engine
  end

  def all
    @invoices
  end

  def add_invoice(invoice_details)
    @invoices << Invoice.new(invoice_details, self)
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
      invoice.status == status.to_sym
    end
  end

  def find_merchant_by_merchant_id(id)
    @sales_engine.find_merchant_by_merchant_id(id)
  end

  def find_invoice_items_by_invoice_id(id)
    @sales_engine.find_invoice_items_by_invoice_id(id)
  end

  def find_item_by_item_id(id)
    @sales_engine.find_item_by_item_id(id)
  end

  def find_transactions_by_invoice_id(id)
    @sales_engine.find_transactions_by_invoice_id(id)
  end

  def find_customer_by_customer_id(id)
    @sales_engine.find_customer_by_customer_id(id)
  end

end

require_relative 'invoice'

class InvoiceRepository

  def initialize
    @invoices = []
  end

  def create(attributes)
    new_invoice = Invoice.new(attributes)
    @invoices << new_invoice
    return new_invoice
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


  def update(id, attributes)
    updated_invoice = find_by_id(id)
    updated_invoice.status = attributes[:status]
    updated_invoice.updated_at = Time.now
  end

  def delete(id)
    deleted_invoice = find_by_id(id)
    @invoices.delete(deleted_invoice)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end





end

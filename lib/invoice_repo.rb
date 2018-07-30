require_relative 'invoice'

class InvoiceRepo 
  attr_accessor :invoices

  def initialize(invoices)
    @invoices = invoices 
    change_invoice_hash_to_object
  end
  
  def change_invoice_hash_to_object
    invoice_array = []
    @invoices.each do |invoice|
      invoice_array << Invoice.new(invoice)
    end
    @invoices = invoice_array
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
      invoice.status.to_sym == status.to_sym
    end
  end
  
  def create(attributes)
    invoice_new = Invoice.new(attributes)
    max_invoice_id = @invoices.max_by do |invoice|
      invoice.id
    end
    new_max_id = max_invoice_id.id + 1
    invoice_new.id = new_max_id
    @invoices << invoice_new
    return invoice_new 
  end
  
  def update(id, attributes)
    invoice_to_change = find_by_id(id)
    return if invoice_to_change.nil?
    invoice_to_change.updated_at = Time.now
    invoice_to_change.status = attributes[:status]
    invoice_to_change 
  end
  
  def delete(id)
    invoice_to_delete = find_by_id(id)
    @invoices.delete(invoice_to_delete)
  end
  
  def find_all_by_day(day)
    days = @invoices.find_all do |invoice|
      invoice.created_at.strftime('%A') == day.to_s
    end
    days
  end
  
end
  
  

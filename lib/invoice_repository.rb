class InvoiceRepository
  attr_reader :invoices

  def initialize(invoices)
    @invoices = invoices
  end 

  def all 
    @invoices
  end 

  def find_by_id(id)
    @invoices.find {|invoice| invoice.id == id}
  end 

  def find_all_by_customer_id(id)
    @invoices.find_all {|invoice| invoice.customer_id == id}
  end 

  def find_all_by_merchant_id(id)
    @invoices.find_all {|invoice| invoice.merchant_id == id}
  end 

  def find_all_by_status(status)
    @invoices.find_all {|invoice| invoice.status == status}
  end 

  def create(attributes)
    ids = @invoices.map { |item| item.id}
    attributes[:id] = ids.max + 1
    new_invoice = Invoice.new(attributes)
    @invoices.push(new_invoice)
    new_invoice
  end

  def update(id, attributes)
    updated_invoice = find_by_id(attributes[:id])
    updated_invoice.update_customer_id(attributes[:customer_id])
    updated_invoice.update_merchant_id(attributes[:merchant_id])
    updated_invoice.update_status(attributes[:status])
    updated_invoice
  end 

  def delete(id)
    @invoices.delete(find_by_id(id))
  end 
end 
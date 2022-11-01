class InvoiceRepo
  
  attr_reader :invoices

  def initialize(data = {})
    @invoices = []
    data.each {|invoice| create(invoice)}
  end

  def create(invoice)
    invoice[:id] ||= (@invoices.last.id.to_i + 1).to_s
    invoice = Invoice.new(invoice)
    @invoices << invoice
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find{|invoice| invoice.id == id.to_s}
  end

  def find_by_customer_id(id)
    @invoices.select{|invoice| invoice.customer_id == id.to_s}
  end

  def find_by_merchant_id(id)
    @invoices.select{|invoice| invoice.merchant_id == id.to_s}
  end

  def find_all_by_status(status)
    @invoices.select{|invoice| invoice.status == status}
  end

  def update(id, status)
    find_by_id(id).update
    find_by_id(id).set_status(status)
  end

  def delete(id)
    @invoices.delete(find_by_id(id))
  end

end




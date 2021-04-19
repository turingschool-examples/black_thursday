class InvoiceRepository
  attr_reader :invoices

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def initialize(filename)
    @invoices = create_invoices(filename)
  end

  def create_invoices(filename)
    FileIo.process_csv(filename, Invoice)
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

  def find_max_id
    @invoices.max_by(&:id).id
  end

  def create(attributes)
    new_invoice = Invoice.new(attributes)
    new_invoice.update_id(find_max_id + 1)
    @invoices << new_invoice
  end

  def update(id, attributes)
    invoice = find_by_id(id)
    unless invoice.nil?
      invoice.update_status(attributes[:status])
      invoice.update_time
    end
  end

  def delete(id)
    invoice = find_by_id(id)
    @invoices.delete(invoice)
  end
end

require_relative './repository'

class InvoiceRepository < Repository

  def initialize
    @collection = {}
  end

  def add_invoice(invoice)
    @collection[invoice.id] = invoice
  end

  def find_all_by_customer_id(id)
    @collection.values.select do |invoice|
      invoice.customer_id == id
    end
  end

  def find_all_by_merchant_id(id)
    @collection.values.select do |invoice|
      invoice.merchant_id == id
    end
  end

  def find_all_by_status(status)
    @collection.values.select do |invoice|
      invoice.status == status
    end
  end

  def create(attributes)
    attributes[:id] = find_new_id
    add_invoice(Invoice.new(attributes))
  end

  def update(id, attributes)
    invoice_to_update = find_by_id(id)
    return nil if invoice_to_update == nil
    invoice_to_update.status = attributes[:status]
    invoice_to_update.updated_at = Time.now
  end

end

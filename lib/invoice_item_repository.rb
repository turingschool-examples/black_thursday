require_relative './repository'

class InvoiceItemRepository < Repository

  def initialize
    @collection = {}
  end

  def add_invoice_item(invoice_item)
    @collection[invoice_item.id] = invoice_item
  end

  def find_by_id(id)
    all.find do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_all_by_item_id(id)
    all.select do |invoice_item|
      invoice_item.item_id == id
    end
  end

  def find_all_by_invoice_id(id)
    all.select do |invoice_item|
      invoice_item.invoice_id == id
    end
  end

  def create(attributes)
    attributes[:id] = find_new_id
    add_invoice_item(InvoiceItem.new(attributes))
  end

  def update(id, attributes)
    invoice_to_update = find_by_id(id)
    return nil if invoice_to_update == nil
    invoice_to_update.quantity = attributes[:quantity]
    invoice_to_update.updated_at = Time.now
  end
end

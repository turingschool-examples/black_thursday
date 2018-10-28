require_relative './repository'

class InvoiceItemsRepository < Repository

  def initialize
    @collection = {}
  end

  def add_invoice_items(invoice_items)
    @collection[invoice_items.id] = invoice_items
  end

  def invoice_items
    @collection.values
  end

  #find_by_id - returns either nil or an instance of
  #InvoiceItems with a matching ID
  def find_by_id(id)
    @collection.values.find do |invoice_items|
      invoice_items.id == id
    end
  end

  def find_all_by_item_id(id)
    @collection.values.select do |invoice_items|
      invoice_items.item_id == id
    end
  end

  def find_all_by_invoice_id(id)
    @collection.values.select do |invoice_items|
      invoice_items.invoice_id == id
    end
  end

  def create(attributes)
    attributes[:id] = find_new_id
    add_invoice_items(InvoiceItems.new(attributes))
  end

#needs work
  def update(id, attributes)
    invoice_to_update = find_by_id(id)
    return nil if invoice_to_update == nil
    invoice_to_update[0].quantity = attributes[:quantity]
    invoice_to_update[0].updated_at = Time.now
  end
end

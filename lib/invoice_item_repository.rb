require_relative './repository'

class InvoiceItemRepository < Repository

  def initialize
    @collection = {}
  end

  def add_invoice_item(invoice_item)
    @collection[invoice_item.id] = invoice_item
  end

  # all?
  def invoice_item
    @collection.values
  end

  #find_by_id - returns either nil or an instance of
  #InvoiceItem with a matching ID
  def find_by_id(id)
    @collection.values.select do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_all_by_item_id(id)
    @collection.values.select do |invoice_item|
      invoice_item.item_id == id
    end
  end

  def find_all_by_invoice_id(id)
    @collection.values.select do |invoice_item|
      invoice_item.invoice_id == id
    end
  end
end

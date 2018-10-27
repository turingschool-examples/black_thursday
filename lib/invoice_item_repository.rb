require_relative './repository'

class InvoiceItemRepository < Repository

  def initialize
    @collection = {}
  end

  def add_invoice(invoice)
    @collection[item.id] = item
  end

  # all?
  def invoice_items
    @collection.values
  end

  #find_by_id - returns either nil or an instance of
  #InvoiceItem with a matching ID
  def find_all_by_item_id(id)
    @collection.values.select do |item|
      item.item_id == id
    end
  end

end

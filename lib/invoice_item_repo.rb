class InvoiceItemRepository

  def initialize(invoice_items)
    @collection = invoice_items
  end

  def all
    @collection
  end

  def find_by_id(ident)
    @collection.find_all do |item|
      item.id == ident
    end
  end

  def find_all_by_item_id(id)
    @collection.find_all do |invoice_item|
      invoice_item.item_id == id
    end
  end

  def find_all_by_invoice_id(id)
    @collection.find_all do |invoice_item|
      invoice_item.invoice_id == id
    end
  end

  def create(attributes)
    item_id = @collection.map do |item|
       item.id
    end
    max_item_id = item_id.max + 1
    InvoiceItem.new(
      id:max_item_id,
      item_id:attributes[:item_id],
      quantity:attributes[:invoice_id],
      unit_price:attributes[:unit_price],
      created_at:attributes[:created_at],
      updated_at:attributes[:updated_at]
    )
  end

  def update(id, attributes)
    updated_item = find_by_id(id)
    updated_item = updated_item[0]
    updated_item.unit_price = attributes[:unit_price] if attributes[:unit_price]
    updated_item.quantity = attributes[:quantity] if attributes[:quantity]
  end

  def delete(item_id)
    @collection.delete_if do |iteminvoice|
      iteminvoice.id == item_id
    end
  end

end

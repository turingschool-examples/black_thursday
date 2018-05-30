require_relative 'invoice_item'
class InvoiceItemRepository
  attr_reader :invoice_item

  def initialize
    @invoice_items = []
  end

  def all
    @invoice_items
  end

  def find_by_id(id)
    @invoice_items.find do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_all_by_item_id(item_id)
    @invoice_items.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_items.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def create(attributes)
    if attributes[:id].nil?
      id = @invoice_items[-1].id + 1
    else
      id = attributes[:id]
    end
    new_invoice_item = InvoiceItem.new({id: id, item_id: attributes[:item_id],
                      invoice_id: attributes[:invoice_id],
                      quantity: attributes[:quantity],
                      unit_price: attributes[:unit_price],
                      created_at: attributes[:created_at].to_s,
                      updated_at: attributes[:updated_at].to_s})
    @invoice_items << new_invoice_item
    return new_invoice_item
  end


  def update(id, attributes)
    if find_by_id(id).nil?
      return
    else
      updated_invoice_item = find_by_id(id)
    end
    updated_invoice_item.quantity = attributes[:quantity]
    updated_invoice_item.unit_price = attributes[:unit_price]
    updated_invoice_item.updated_at = Time.now
  end


  def delete(id)
    deleted_invoice_item = find_by_id(id)
    @invoice_items.delete(deleted_invoice_item)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end

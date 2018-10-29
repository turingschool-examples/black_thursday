require_relative "../lib/repository"
require_relative "../lib/invoice_item"
require "time"
class InvoiceItemRepository
  include Repository
  def initialize(invoice_items)
    @collection = invoice_items
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
    created = InvoiceItem.new({
      id:max_id + 1,
      item_id:attributes[:item_id],
      quantity:attributes[:invoice_id],
      unit_price:attributes[:unit_price],
      created_at:attributes[:created_at],
      updated_at:attributes[:updated_at]
    })
    all << created
    created
  end

  def update(id, attributes)

    updated_item = find_by_id(id)
    if updated_item
      updated_item.unit_price = attributes[:unit_price] if attributes[:unit_price]
      updated_item.quantity = attributes[:quantity] if attributes[:quantity]
      updated_item.updated_at = Time.now
    end
  end

  def delete(item_id)
    @collection.delete_if do |iteminvoice|
      iteminvoice.id == item_id
    end
  end

end

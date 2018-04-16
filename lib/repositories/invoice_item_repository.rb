require_relative '../elementals/invoice_item'
require_relative 'repository'

# Invoiceitem repo class
class InvoiceItemRepository < Repository
  attr_reader :invoice_items

  def initialize(invoice_items_data)
    @invoice_items = create_index(InvoiceItem, invoice_items_data)
    super(invoice_items, InvoiceItem)
  end

  def find_all_by_item_id(item_id)
    @invoice_items.values.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_items.values.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def update(id, attrs)
    return unless @invoice_items[id]
    @invoice_items[id].quantity = attrs[:quantity] if attrs[:quantity]
    @invoice_items[id].unit_price = attrs[:unit_price] if attrs[:unit_price]
    @invoice_items[id].updated_at = Time.now
  end
end

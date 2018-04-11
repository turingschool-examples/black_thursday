require_relative '../lib/invoiceitem'
require_relative 'repository'

# Invoiceitem repo class
class InvoiceItemRepository < Repository
  attr_reader :invoice_items

  def initialize(csv_parsed_array)
    csv_parsed_array.shift
    attributes = csv_parsed_array.map do |invoice_item|
      { id: invoice_item[0].to_i,
        item_id: invoice_item[1].to_i,
        invoice_id: invoice_item[2].to_i,
        quantity: invoice_item[3].to_i,
        unit_price: invoice_item[4],
        created_at: Time.parse(invoice_item[5]),
        updated_at: Time.parse(invoice_item[6]) }
    end
    @invoice_items = create_index(InvoiceItem, attributes)
    super(invoice_items, InvoiceItem)
  end

  def find_all_by_item_id(item_id)
    @invoice_items.values.map do |invoice_item|
      invoice_item if invoice_item.item_id == item_id
    end.compact
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_items.values.map do |invoice_item|
      invoice_item if invoice_item.invoice_id == invoice_id
    end.compact
  end

  def update(id, attributes)
    if @invoice_items[id]
      @invoice_items[id].quantity = attributes[:quantity] if attributes[:quantity]
      @invoice_items[id].unit_price = attributes[:unit_price] if attributes[:unit_price]
      @invoice_items[id].updated_at = Time.now
    end
  end
end

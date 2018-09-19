require './test/helper'

class InvoiceItemRepository
attr_reader :invoice_items

  def initialize(invoice_items_path)
    @invoice_items = []
    make_invoice_items(invoice_items_path)
  end

  def make_invoice_items(invoice_items_path)
    CSV.foreach(invoice_items_path, headers: true, header_converters: :symbol) do |row|
      @invoice_items << InvoiceItem.new(row)
    end
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
    @invoice_items.find_all do |invoice|
      invoice.item_id.to_i == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_items.find_all do |invoice|
      invoice.invoice_id.to_i == invoice_id
    end
  end

  def create(attributes)
    attributes[:id] = @invoice_items[-1].id += 1
    new_invoice = InvoiceItem.new(attributes)
    @invoice_items << new_invoice
    new_invoice
  end

  def update(id, attribute)
    invoice_item = find_by_id(id)
    return if invoice_item.nil?
    updated_quantity = attribute[:quantity]
    invoice_item.quantity = updated_quantity
    updated_unit_price = attribute[:unit_price]
    invoice_item.unit_price = updated_unit_price
    invoice_item
  end

  def delete(id)
    find_invoice = find_by_id(id)
    @invoice_items.delete_if do |invoice|
     invoice == find_invoice
    end
  end
end

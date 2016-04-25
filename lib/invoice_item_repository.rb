require_relative 'invoice_item'

class InvoiceItemRepository
  attr_reader :invoice_items, :item_id, :id

  def initialize(invoice_items_data)
    @invoice_items = create_invoice_items(invoice_items_data)
  end

  def create_invoice_items(invoice_items_data)
    invoice_items_data.map do |invoice_item|
      InvoiceItem.new(invoice_item)
    end
  end

  def all
    invoice_items
  end

  def find_by_id(id)
    invoice_items.find { |invoice_item| invoice_item.id == id }
  end

  def find_all_by_item_id(item_id)
    invoice_items.find_all { |invoice_item| invoice_item.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_items.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def inspect
  "#<#{self.class} #{@invoice_items.size} rows>"
  end

end

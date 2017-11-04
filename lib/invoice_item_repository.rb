require_relative './invoice_item'
class InvoiceItemRepository

  attr_reader :invoice_items,
              :parent

  def initialize(invoice_items, parent)
    @invoice_items = invoice_items.map {|invoice_item| InvoiceItem.new(invoice_item, self)}
    @parent = parent
  end

  def all
    invoice_items
  end

  def find_by_id(id)
    invoice_items.find do |invoice_item|
      invoice_item.id.to_i == id.to_i
    end
  end

  def find_all_by_item_id(item_id)
    invoice_items.find_all do |invoice_item|
      invoice_item.item_id.to_i == item_id.to_i
    end
  end

  def find_by_invoice_id(invoice_id)
    invoice_items.find_all do |invoice_item|
      invoice_item.invoice_id.to_i == invoice_id.to_i
    end
  end
end

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
end

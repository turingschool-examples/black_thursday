require_relative 'invoice_item'

class InvoiceItemRepository
  attr_reader :invoice_items, :parent

  def initialize(invoice_item_contents, parent = nil)
    @invoice_items = make_invoice_items(invoice_item_contents)
    @parent = parent
  end

  def make_invoice_items(invoice_item_contents)
    invoice_item_contents.map { |row| InvoiceItem.new(row, self) }
  end

  def all
    @invoice_items
  end

  def find_by_id(id)
    @invoice_items.find { |invoice_item| invoice_item.id == id }
  end

  # def find_all_by_price(price)
  #   @invoice_items.find_all { |invoice_item| invoice_item.unit_price == price }
  # end
  #
  # def find_all_by_price_in_range(range)
  #   @invoice_items.find_all { |invoice_item| range.include? invoice_item.unit_price }
  # end

  def find_all_by_item_id(item_id)
    @invoice_items.find_all { |invoice_item| invoice_item.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_items.find_all { |invoice_item| invoice_item.invoice_id == invoice_id }
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end
end

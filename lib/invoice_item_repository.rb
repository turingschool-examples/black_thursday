require_relative 'invoice_item'
require_relative 'invoice'
require_relative 'item'


class InvoiceItemRepository

  attr_reader :invoice_items, :sales_engine

  def initialize(invoice_items, sales_engine = nil)
    @invoice_items = invoice_items
    @sales_engine = sales_engine
  end

  def all
    invoice_items
  end

  def find_by_id(id)
    invoice_items.find { |row| row.id == id }
  end

  def find_all_by_item_id(item_id)
    invoice_items.select { |row| row.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_items.select { |row| row.invoice_id == invoice_id }
  end

  def inspect
  "#<#{self.class} #{@merchants.size} rows>"
  end
end

require 'csv'
require_relative '../lib/invoice_item'
require_relative '../lib/create_elements'

class InvoiceItemRepository

  include CreateElements

  attr_reader :invoice_items, :engine

  def initialize(items_file, engine)
    @invoice_items = create_elements(items_file).map {
      |item_invoice| InvoiceItem.new(item_invoice, self)}
    @engine = engine
  end

  def all
    return invoice_items
  end

  def find_by_id(id)
    invoice_items.find do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_all_by_item_id(item_id)
    invoice_items.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
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

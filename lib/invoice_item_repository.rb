require 'csv'
require_relative './invoice_item'

class InvoiceItemRepository
  attr_reader :invoice_items

  def initialize
    @invoice_items = []
  end

  def create(attributes)
    attributes[:id] = (@invoice_items.last.id + 1) if invoice_items.last.nil? == false
    new_invoice_item = InvoiceItem.new(attributes)
    @invoice_items << new_invoice_item
    new_invoice_item
  end

  def all
    @invoice_items
  end

  def find_by_id(id)
    invoice_items.find { |invoice_item| invoice_item.id == id }
  end

  def find_by_item_id(id)
    invoice_items.select { |invoice_item| invoice_item.item_id == id }
  end

  def find_all_by_invoice_id(id)
    invoice_items.select { |invoice_item| invoice_item.invoice_id == id }
  end

  def update(id, attributes)
    find_by_id(id).update(attributes) unless find_by_id(id).nil?
  end

  def delete(id)
    invoice_items.delete_if { |invoice_item| invoice_item.id.== id }
  end
end

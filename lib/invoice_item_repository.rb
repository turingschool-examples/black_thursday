require 'csv'
require_relative 'invoice_item'
require_relative 'repository'

# Repository Linking items to invoices
class InvoiceItemRepository
  include Repository
  attr_reader :engine

  def initialize(filepath, parent = nil)
    @csv_items = []
    @engine   = parent
    load_children(filepath)
  end

  def invoice_items
    @csv_items
  end

  def child
    InvoiceItem
  end

  def find_all_by_item_id(id)
    invoice_items.find_all { |invoice_item| invoice_item.item_id == id }
  end

  def find_all_by_invoice_id(id)
    invoice_items.find_all { |invoice_item| invoice_item.invoice_id == id }
  end
end

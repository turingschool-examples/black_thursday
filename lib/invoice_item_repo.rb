require 'csv'
require_relative './sales_engine'

class InvoiceItemRepository

  def initialize(data)
    @invoice_items = data
  end

  def all
    @invoice_items
  end

  def find_by_id(id)
    invoice_item_id = nil
    @invoice_items.select do |invoice_item|
      if invoice_item.id == id
        invoice_item_id = invoice_item
      end
    end
    invoice_item_id
  end

  def find_all_by_item_id(id)
    @invoice_items.find_all do |invoice_item|
      if invoice_item.item_id == id
        invoice_item
      end
    end
  end
end

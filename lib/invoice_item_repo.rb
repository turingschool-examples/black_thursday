require "csv"
require_relative "../lib/invoice_item"

class InvoiceItemRepo

  def initialize(filepath, parent = nil)
    contents = CSV.open filepath, headers: true, header_converters: :symbol
    @invoice_item_objects = contents.map do |row|
      InvoiceItem.new(row, self)
    end
    @parent = parent
  end

  def all
    @invoice_item_objects
  end

  def find_by_id(invoice_item_id)
    @invoice_item_objects.detect do |invoice_item|
      invoice_item.id == invoice_item_id
    end
  end

  def find_all_by_item_id(item_id)
    @invoice_item_objects.select do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_item_objects.select do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def find_item_by_id(item_id)
    @parent.find_item_by_id(item_id)
  end
end

require_relative "invoice_item"
require "csv"

class InvoiceItemRepository
  attr_reader :invoice_items

  def initialize(invoice_items_file)
    @invoice_items = []
    items_from_csv(invoice_items_file)
  end

  def items_from_csv(invoice_items_file)
    CSV.foreach(invoice_items_file, headers: true, header_converters: :symbol) do |row|
      @invoice_items << InvoiceItem.new(row)
    end
  end

  def all
    @invoice_items
  end

  def find_by_id(id)
    @invoice_items.find {|inv_item| inv_item.id == id}
  end

  def find_all_by_item_id(item_id)
    @invoice_items.find_all {|inv_item| inv_item.item_id == item_id}
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_items.find_all {|inv_item| inv_item.invoice_id == invoice_id}
  end
end

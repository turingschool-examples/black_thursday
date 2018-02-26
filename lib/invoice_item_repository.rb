require_relative 'invoice_item'
require 'csv'

# This is the invoice item repo class.
class InvoiceItemRepository
  attr_reader :parent, :invoice_items
  def initialize(invoice_item_csv, parent)
    @parent = parent
    @invoice_items = []

    csv = CSV.open(invoice_item_csv, headers: true, header_converters: :symbol)
    csv.each do |row|
      @invoice_items << InvoiceItem.new(row, self)
    end
  end

  def all
    @invoice_items
  end

  def find_by_id(id)
    @invoice_items.find { |invoice_item| invoice_item.id == id }
  end

  def find_all_by_item_id(item_id)
    @invoice_items.find_all { |invoice_item| invoice_item.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_items.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def find_all_by_mult_invoice_ids(invoice_id_array)
    invoice_id_array.map { |invoice_id| find_all_by_invoice_id(invoice_id) }
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end
end

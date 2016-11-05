require_relative 'invoice'
require 'csv'

class InvoiceRepository
  attr_reader   :contents,
                :invoice_items,
                :parent

  def initialize(path, parent = nil)
    @contents = CSV.open path, headers: true, header_converters: :symbol
    @parent = parent
    @invoice_items = contents.map do |line|
      InvoiceItem.new(line, self)
    end
  end

  def all
    invoice_items
  end

  def find_by_id(id_number)
    invoice_items.find do |invoice_item|
      invoice_item.id == id_number
    end
  end

  def find_all_by_item_id(item_id)
    invoice_items.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_items.find_all do |invoice_item|
      invoice.invoice_id == invoice_id
    end
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

end
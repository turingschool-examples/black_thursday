require 'csv'
require_relative 'invoice_item'

class InvoiceItemRepo
  attr_reader :invoice_items, :parent

  def initialize(file, se=nil)
    @invoice_items = {}
    open_file(file)
    @parent = se
  end

  def open_file(file)
    CSV.foreach file, headers: true, header_converters: :symbol do |row|
      invoice_items[row[:id].to_i] = InvoiceItem.new(row, self)
    end
  end

  def all
    invoice_items.values
  end

  def find_by_id(id)
    all.find { |ii| ii.id == id }
  end

  def find_all_by_item_id(item_id)
    all.find_all { |ii| ii.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all { |ii| ii.invoice_id == invoice_id}
  end
end

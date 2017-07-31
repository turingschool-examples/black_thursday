require 'csv'
require_relative 'invoice_item'

class InvoiceItemRepo
  attr_reader :invoice_items, :parent

  def initialize(filename, se=nil)
    @invoice_items = {}
    open_file(filename)
    @parent        = se
  end

  def open_file(filename)
    CSV.foreach filename, headers: true, header_converters: :symbol do |row|
      invoice_items[row[:id].to_i] = InvoiceItem.new(row, self)
    end
  end

  def all
    invoice_items.values
  end

  def find_by_id(id)
    invoice_items[id]
  end

  def find_all_by_item_id(item_id)
    all.find_all {|invoice_item| invoice_item.item_id == item_id}
  end

  def find_all_by_invoice_id(inv_id)
    all.find_all {|invoice_item| invoice_item.invoice_id == inv_id}
  end


end

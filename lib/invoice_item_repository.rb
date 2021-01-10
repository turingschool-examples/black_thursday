require_relative 'invoice_item'
require 'bigdecimal'
require 'bigdecimal/util'
require 'time'
require "csv"

class InvoiceItemRepository
  attr_reader :filename,
              :parent,
              :invoice_item

  def initialize(filename, parent)
    @filename = filename
    @parent = parent
    @invoice_item = Array.new
    generate_invoices(filename)
  end

  def inspect
    "#<#{self.class} #{@invoice_item.size} rows>"
  end

  def generate_invoices(filename)
    invoice_items = CSV.open filename, headers: true, header_converters: :symbol
    invoice_items.each do |row|
      @invoice_item << InvoiceItem.new(row, self)
    end
  end

end

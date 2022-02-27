require_relative '../lib/invoice_item'
require 'bigdecimal'
require 'CSV'
require 'time'


class InvoiceItemRepository

  attr_reader :filename, :invoice_items

  def initialize(filename)
    @filename = filename
    @invoice_items = self.all
  end

  def rows
    rows = CSV.read(@filename, headers: true, header_converters: :symbol)
  end

  def all
    rows.map {|row| InvoiceItem.new(row)}
  end

end

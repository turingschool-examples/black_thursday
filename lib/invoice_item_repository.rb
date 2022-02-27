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

  def find_by_id(id)
    @invoice_items.find {|invoice_item| invoice_item.id == id}
  end

  def find_all_by_item_id(id)
    @invoice_items.find_all {|invoice_item| invoice_item.id == id}
  end

end

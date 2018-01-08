require_relative '../lib/invoice_item'
require_relative '../lib/csv_parser'
require 'csv'

class InvoiceItemRepository

  include CsvParser

  attr_reader :invoice_items

  def initialize(csv_file, se)
    @invoice_items = []
    @se = se
    parser(csv_file).each { |row| @invoice_items << InvoiceItem.creator(row, self)}
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  def all
    invoice_items
  end

  def find_by_id(id)
    invoice_items.find { |invoice_item| invoice_item if invoice_item.id == id }
  end

  def find_all_by_item_id(item_id)
    invoice_items.find_all { |invoice_item| invoice_item.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_items.find_all { |invoice_item| invoice_item.invoice_id == invoice_id }
  end

  

end

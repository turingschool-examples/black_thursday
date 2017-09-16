require_relative 'csv_parser'
require_relative 'invoice_item'
require 'bigdecimal'

class InvoiceItemRepository
  include CsvParser
  attr_accessor :invoice_items
  def initialize
    @invoice_items = []
  end

  def from_csv(file_name)
    item_contents = parse_data(file_name)
    item_contents.each do |row| #should live in it's own method. too much logic in the initialize (some people will say that you should'nt have behavior in initialize, only state)
      @invoice_items << InvoiceItem.new(
        {id: row[:id].to_i,
        item_id: row[:item_id],
        invoice_id: row[:invoice_id].to_i,
        quantity: row[:quantity].to_i,
        unit_price: BigDecimal.new(row[:unit_price],4)/100,
        updated_at: row[:updated_at],
        created_at: row[:created_at]},
        self)
    end
  end

  def all
    @invoice_items
  end

  def find_by_id(id)
    @invoice_items.find {|invoice_item| invoice_item.id == id }
  end

  def find_all_by_item_id(item_id)
    @invoice_items.select {|invoice_item| invoice_item.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_items.select {|invoice_item| invoice_item.invoice_id == invoice_id }
  end

end

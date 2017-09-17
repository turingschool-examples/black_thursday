require_relative 'csv_parser'
require_relative 'invoice_item'

class InvoiceItemRepository
  include CsvParser
  attr_accessor :invoice_items

  def initialize(file_name, sales_engine)
    @invoice_items = []
    item_contents = parse_data(file_name)
    item_contents.each do |row|
      @invoice_items << InvoiceItem.new(row, self)
    end
    @sales_engine = sales_engine
  end

  # def from_csv(file_name)
  #   item_contents = parse_data(file_name)
  #   item_contents.each do |row| #should live in it's own method. too much logic in the initialize (some people will say that you should'nt have behavior in initialize, only state)
  #     @invoice_items << InvoiceItem.new(row, self)
  #   end
  # end

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
    @invoice_items.select {|invoice_item|
       invoice_item.invoice_id == invoice_id }
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end

require_relative 'invoice_item'
require_relative 'sales_engine'
require 'csv'

class InvoiceItemRepository

  attr_reader :all, :invoice_items, :sales_engine

  def initialize(sales_engine, item_csv)
    @all = []
    @sales_engine = sales_engine
    CSV.foreach(item_csv, headers: true, header_converters: :symbol) do |row|
      all << InvoiceItem.new(self, row)
    end
  end

  def find_by_id(id)
    all.each do |invoice_item|
      return invoice_item if invoice_item.id.to_i == id
    end
    nil
  end

  def find_all_by_item_id(item_id)
    invoice_item_array = []
    all.each do |invoice_item|
      invoice_item_array << invoice_item if invoice_item.item_id == item_id
    end
    invoice_item_array
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_item_array = []
    all.each do |invoice_item|
      invoice_item_array << invoice_item if invoice_item.invoice_id == invoice_id
    end
    invoice_item_array
  end

  def inspect
    "#<#{self.class} #{:invoice_items.size} rows>"
  end

end

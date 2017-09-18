require_relative 'invoice_item'
require 'csv'

class InvoiceItemRepository

  attr_reader :all, :parent

  def initialize(file_path, parent = nil)
    @all = from_csv(file_path)
    @parent = parent
  end

  def from_csv(file_path)
    invoice_items = []
    CSV.foreach(file_path, headers: true, :header_converters => :symbol) do |row|
      invoice_items << InvoiceItem.new(row, self)
    end
    invoice_items
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def find_by_id(id)
    @all.find do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_all_by_item_id(item_id)
    @all.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

end

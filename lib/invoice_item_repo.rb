require_relative 'invoice_item'

class InvoiceItemRepository
  attr_reader :invoice_items

  def initialize(invoice_item_file, sales_engine)
    @invoice_items = read_invoice_item_file(invoice_item_file)
    @sales_engine = sales_engine
  end

  def read_invoice_item_file(invoice_item_file)
    invoice_item_list =[]
    CSV.foreach(invoice_item_file, headers: true,
    header_converters: :symbol) do |row|
      invoice_item_info = {}
      invoice_item_info[:id] = row[:id]
      invoice_item_info[:item_id] = row[:item_id]
      invoice_item_info[:invoice_id] = row[:invoice_id]
      invoice_item_info[:quantity] = row[:quantity]
      invoice_item_info[:unit_price] = row[:unit_price]
      invoice_item_info[:created_at] =row[:created_at]
      invoice_item_info[:updated_at] = row[:updated_at]
      invoice_item_list << InvoiceItem.new(invoice_item_info, self)
    end
    invoice_item_list
  end

  def all
    invoice_items
  end

  def find_by_id(id)
    invoice_items.find { |invoice_item| invoice_item.id == id }
  end

  def find_all_by_item_id(item_id)
    invoice_items.find_all { |invoice_item| invoice_item.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_items.find_all do
      |invoice_item| invoice_item.invoice_id == invoice_id
    end
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end
end

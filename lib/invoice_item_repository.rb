require_relative 'invoice_item'
require 'pry'

class InvoiceItemRepository

  attr_reader :invoice_items,
              :se

  def initialize(invoice_items_path, se)
    @se = se
    @invoice_items = []
    contents = CSV.open invoice_items_path,
                        headers: true,
                        header_converters: :symbol
    contents.each do |row|
      id = (row[:id]).to_i
      item_id = row[:item_id].to_i
      invoice_id = row[:invoice_id].to_i
      quantity = row[:quantity]
      unit_price = row[:unit_price]
      created_at = row[:created_at]
      updated_at = row[:updated_at]
      invoice_item = InvoiceItem.new(id, item_id, invoice_id,
                                     quantity, unit_price,
                                     created_at, updated_at, self)
      @invoice_items << invoice_item
    end
  end

  def all
    @invoice_items
  end

  def find_by_id(invoice_item_id)
    @invoice_items.find do |invoice_item|
      invoice_item.id == invoice_item_id
    end
  end

  def find_all_by_item_id(item_id)
    @invoice_items.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_items.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

end

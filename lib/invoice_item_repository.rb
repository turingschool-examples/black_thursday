require_relative '../lib/invoice_item'
require 'csv'

class InvoiceItemRepository
  def initialize(file_path)
    @invoice_items = []
    invoice_item_data = CSV.open file_path, headers: true, header_converters: :symbol, converters: :numeric
    parse(invoice_item_data)
  end

  def self.from_csv(file_path)
    new(file_path)
  end

  def parse(invoice_item_data)
    invoice_item_data.each do |row|
      @invoice_items << InvoiceItem.new(row.to_hash)
    end
  end

  def all
    return @invoice_items
  end

  def find_by_id(id)
    @invoice_items.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_item_id(item_id)
    @invoice_items.find_all do |invoice|
      invoice.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_items.find_all do |invoice|
      invoice.invoice_id == invoice_id
    end
  end
end

require_relative '../lib/invoice_item'
require 'csv'

class InvoiceItemRepository
  def initialize(parent)
    @invoice_items = Hash.new {|hash, invoice_id| hash[invoice_id] = []}
    @invoices = parent
  end

  def from_csv(file_path)
    invoice_item_data = CSV.open file_path, headers: true,
      header_converters: :symbol, converters: :numeric
    invoice_item_data.each do |row|
      @invoice_items[row[:invoice_id]] << InvoiceItem.new(row.to_hash, self)
    end
  end

  def all
    return @invoice_items.values.flatten
  end

  def find_by_id(id)
    @invoice_items.values.flatten.find do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_all_by_item_id(item_id)
    @invoice_items.values.flatten.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_items[invoice_id]
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end
end

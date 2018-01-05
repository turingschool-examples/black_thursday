require_relative '../lib/invoice_item'
require 'csv'

class InvoiceItemRepository
  def initialize(file_path)
    @invoice_items = []
    invoice_item_data = CSV.open file_path, headers: true, header_converters: :symbol, converters: :numeric
    parse(invoice_item_data)
  end

  def parse(invoice_item_data)
    invoice_item_data.each do |row|
      @invoice_items << InvoiceItem.new(row.to_hash)
    end
  end

  def all
    return @invoice_items
  end
end

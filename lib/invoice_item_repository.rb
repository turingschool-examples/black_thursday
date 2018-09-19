require_relative 'helper'

class InvoiceItemRepository
attr_reader :invoice_items

  def initialize(invoice_items_path)
    @invoice_items = []
    make_invoice_items(invoice_items_path)
  end

  def make_invoice_items(invoice_items_path)
    CSV.foreach(invoice_items_path, headers: true, header_converters: :symbol) do |row|
      @invoice_items << InvoiceItem.new(row)
    end
  end
end

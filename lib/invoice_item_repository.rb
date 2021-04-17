require_relative 'sales_engine'
require_relative 'invoice_item'
require_relative 'mathable'

class InvoiceItemRepository
  include Mathable
  attr_reader :invoice_items


  def initialize(path, engine)
    @invoice_items = []
    @engine = engine
    make_invoice_items(path)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def make_invoice_items(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @invoice_items << InvoiceItem.new(row, self)
    end
  end
end

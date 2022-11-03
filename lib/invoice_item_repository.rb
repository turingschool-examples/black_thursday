class InvoiceItemRepository
  attr_reader :invoice_items

  def initialize
    @invoice_items = []
  end

  def add(invoice_item)
    @invoice_items << InvoiceItem.new(invoice_item)
  end

  def all
    @invoice_items
  end
end
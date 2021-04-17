class InvoiceItemRepository
  attr_reader :invoice_items

  def initialize(filename)
    @invoice_items = create_invoice_items(filename)
  end

  def create_invoice_items
    FileIo.process_csv(filename, InvoiceItem)
  end

  def all
    @invoice_items
  end
end
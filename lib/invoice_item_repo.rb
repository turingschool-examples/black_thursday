class InvoiceItemRepository

  def initialize(invoice_items)
    @collection = invoice_items
  end

  def all
    @collection
  end


end

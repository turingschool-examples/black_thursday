class InvoiceItemRepository

  def initialize(invoice_items)
    @collection = invoice_items
  end

  def all
    @collection
  end

  def find_by_id(ident)
    @collection.find_all do |item|
      item.id == ident
    end
  end

end

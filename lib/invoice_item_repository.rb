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

  def find_by_id(id)
    @invoice_items.find do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_all_by_item_id(id)
    @invoice_items.select do |invoice_item|
      invoice_item.item_id == id
    end
  end

  def find_all_by_invoice_id(id)
    @invoice_items.select do |invoice_item|
      invoice_item.invoice_id == id
    end
  end
end

class InvoiceItemRepository

  def initialize(csv_data, engine)
    @engine        = engine
    @invoice_items = csv_data
  end

  def all
    invoice_items
  end

  def find_by_id(id)
    invoice_items.detect { |invoice_item| invoice_item.id == id }
  end

  def find_all_by_item_id(item_id)
    invoice_items.select { |invoice_item| invoice_item.item_id == item_id } || []
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_items.select { |invoice_item| invoice_item.invoice_id == invoice_id } || []
  end



end

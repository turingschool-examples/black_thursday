class InvoiceItemRepository

  def all
  end

  def find_by_id(invoice_item_id)
  end

  def find_all_by_item_id(item_id)
  end

  def find_all_by_invoice_id(invoice_id)
  end

  def inspect
  "#<#{self.class} #{@invoice_items.size} rows>"
end
end

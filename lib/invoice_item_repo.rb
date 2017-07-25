class InvoiceItemRepository

  def all
    # returns an array of all known InvoiceItem instances
  end

  def find_by_id
    # returns either nil or an instance of InvoiceItem with a matching ID
  end

  def find_all_by_item_id
    # returns either [] or one or more matches which have a matching item ID
  end

  def find_all_by_invoice_id
    # returns either [] or one or more matches which have a matching invoice ID
  end



end

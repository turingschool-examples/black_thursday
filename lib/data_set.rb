module DataSet
  def merchants
    @merchants ||= merchant_repo.all
  end

  def items
    @items ||= item_repo.all
  end

  def invoices
    @invoices ||= invoice_repo.all
  end

  def transactions
    @transactions ||= transaction_repo.all
  end

  def invoice_items
    @invoice_items ||= invoice_item_repo.all
  end

  def customers
    @customers ||= customer_repo.all
  end
end

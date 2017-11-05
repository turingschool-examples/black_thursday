module EngineReaders
  def items
    if @items.nil?
      @items = ItemRepository.new(item_file, self)
    end
    @items
  end

  def invoice_items
    if @invoice_items.nil?
      @invoice_items = InvoiceItemRepository.new(invoice_item_file, self)
    end
    @invoice_items
  end

  def customers
    if @customers.nil?
      @customers = CustomerRepository.new(customer_file, self)
    end
    @customers
  end

  def transactions
    if @transactions.nil?
      @transactions = TransactionRepository.new(transaction_file, self)
    end
    @transactions
  end

  def invoices
    if @invoices.nil?
      @invoices = InvoiceRepository.new(invoice_file, self)
    end
    @invoices
  end

  def merchants
    if @merchants.nil?
      @merchants = MerchantRepository.new(merchant_file, self)
    end
    @merchants
  end
end

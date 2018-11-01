module TestSetup

  def setup_fixtures
    @se = SalesEngine.from_csv(
      {
        items: './test/data/test_items.csv',
        merchants: './test/data/test_merchants.csv',
        invoices: './test/data/test_invoices.csv',
        invoice_items: './test/data/test_invoice_items.csv',
        transactions: './test/data/test_transactions.csv',
        customers: './test/data/test_customers.csv'
      }
    )
    @sa = @se.analyst
  end

  def setup_empty_sales_engine
    @now = Time.now
    @items = ItemRepository.new
    @merchants = MerchantRepository.new
    @invoices = InvoiceRepository.new
    @invoice_items = InvoiceItemRepository.new
    @customers = CustomerRepository.new
    @transactions = TransactionRepository.new
    @se = SalesEngine.new(@items, @merchants, @invoices, @invoice_items, @customers, @transactions)
    @sa = @se.analyst
  end
end

module TestSetup
  def setup_big_data_set
    se = SalesEngine.from_csv(
      {
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv',
        customers: './data/customers.csv'
      }
    )
    @sa = se.analyst
  end

  def setup_fixtures
    se = SalesEngine.from_csv(
      {
        items: './test/data/test_items.csv',
        merchants: './test/data/test_merchants.csv',
        invoices: './test/data/test_invoices.csv',
        invoice_items: './test/data/test_invoice_items.csv',
        transactions: './test/data/test_transactions.csv',
        customers: './test/data/test_customers.csv'
      }
    )
    @sa = se.analyst
  end

  def setup_empty_sales_engine
    item_repository = ItemRepository.new
    merchant_repository = MerchantRepository.new
    invoice_repository = InvoiceRepository.new
    invoice_items_repository = InvoiceItemRepository.new
    customers_repository = CustomerRepository.new
    transactions_repository = TransactionRepository.new
    @se = SalesEngine.new(item_repository, merchant_repository, invoice_repository, invoice_items_repository, customers_repository, transactions_repository)
    @sa = @se.analyst
  end
end

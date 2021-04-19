require './data/invoice_mocks'
require './data/invoice_item_mocks'
require './data/item_mocks'
require './data/merchant_mocks'

require './lib/customer_repository'
require './lib/invoice_repository'
require './lib/invoice_item_repository'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/sales_engine'
require './lib/transaction_repository'

class SalesEngineMocks
  def self.sales_engine(eg)
    mock_items = ItemMocks.items_as_mocks(eg)
    eg.allow_any_instance_of(ItemRepository).to eg.receive(:create_items).and_return(mock_items)

    mock_merchants = MerchantMocks.merchants_as_mocks(eg)
    eg.allow_any_instance_of(MerchantRepository).to eg.receive(:create_merchants).and_return(mock_merchants)

    mock_invoices = InvoiceMocks.invoices_as_mocks(eg)
    eg.allow_any_instance_of(InvoiceRepository).to eg.receive(:create_invoices).and_return(mock_invoices)

    mock_transactions = TransactionMocks.transactions_as_mocks(eg)
    eg.allow_any_instance_of(TransactionRepository).to eg.receive(:create_transactions).and_return(mock_transactions)

    mock_invoice_items = InvoiceItemMocks.invoice_items_as_mocks(eg)
    eg.allow_any_instance_of(InvoiceItemRepository).to eg.receive(:create_invoice_items).and_return(mock_invoice_items)

    mock_customers = CustomerMocks.customers_as_mocks(eg)
    eg.allow_any_instance_of(CustomerRepository).to eg.receive(:create_customers).and_return(mock_customers)

    files = { items: './file1.csv', merchants: './file2.csv', invoices: './file3.csv',
              transactions: './file4.csv', invoice_items: './file5.csv', customers: './file6.csv' }
    SalesEngine.from_csv(files)
  end
end

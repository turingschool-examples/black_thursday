require 'csv'
require 'rspec'
require './data/invoice_mocks'
require './data/item_mocks'
require './data/merchant_mocks'
require './data/invoice_item_mocks'
require './data/Mockable'
require './lib/file_io'
require './lib/invoice_repository'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/sales_engine'
require './lib/sales_analyst'
require './lib/transaction_repository'
require './lib/invoice_item_repository'
require './lib/customer_repository'
require './lib/customer'

describe SalesEngine do
  details = {
    id: 6,
    invoice_id: 8,
    credit_card_number: '4242424242424242',
    credit_card_expiration_date: '0220',
    result: 'success',
    created_at: Time.now,
    updated_at: Time.now
  }
  data_hashes = []
  10.times { data_hashes << details }

  customer_details = {
    id: 1,
    first_name: 'Julia',
    last_name: 'Child',
    created_at: Time.now,
    updated_at: Time.now
  }
  customer_hashes = []
  10.times { customer_hashes << customer_details }

  describe '#from_csv' do
    it 'creates a new instance of SalesEngine' do
      mock_items = ItemMocks.items_as_mocks(self)
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_items)
      mock_merchants = MerchantMocks.merchants_as_mocks(self)
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_merchants)
      mock_invoices = InvoiceMocks.invoices_as_mocks(self)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_invoices)
      mock_transactions = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_transactions)
      mock_invoice_items = InvoiceItemMocks.invoice_items_as_mocks(self)
      allow_any_instance_of(InvoiceItemRepository).to receive(:create_invoice_items).and_return(mock_invoice_items)
      mock_customers = Mockable.mock_generator(self, 'Customer', customer_hashes)
      allow_any_instance_of(CustomerRepository).to receive(:create_customers).and_return(mock_customers)
      files = { items: './file1.csv', merchants: './file2.csv', invoices: './file3.csv', transactions: './file4.csv', invoice_items: './file5.csv', customers: './file6.csv' }
      sales_engine = SalesEngine.from_csv(files)

      expect(sales_engine).to be_instance_of SalesEngine
    end
  end

  describe '#items' do
    it 'has an ItemRepository' do
      mock_items = ItemMocks.items_as_mocks(self)
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_items)
      mock_merchants = MerchantMocks.merchants_as_mocks(self)
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_merchants)
      mock_invoices = InvoiceMocks.invoices_as_mocks(self)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_invoices)
      mock_transactions = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_transactions)
      mock_invoice_items = InvoiceItemMocks.invoice_items_as_mocks(self)
      allow_any_instance_of(InvoiceItemRepository).to receive(:create_invoice_items).and_return(mock_invoice_items)
      mock_customers = Mockable.mock_generator(self, 'Customer', customer_hashes)
      allow_any_instance_of(CustomerRepository).to receive(:create_customers).and_return(mock_customers)
      files = { items: './file1.csv', merchants: './file2.csv', invoices: './file3.csv', transactions: './file4.csv', invoice_items: './file5.csv', customers: './file6.csv' }
      sales_engine = SalesEngine.from_csv(files)

      expect(sales_engine.items).is_a? ItemRepository
    end

    it 'has Items in the ItemRepository' do
      mock_items = ItemMocks.items_as_mocks(self)
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_items)
      mock_merchants = MerchantMocks.merchants_as_mocks(self)
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_merchants)
      mock_invoices = InvoiceMocks.invoices_as_mocks(self)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_invoices)
      mock_transactions = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_transactions)
      mock_invoice_items = InvoiceItemMocks.invoice_items_as_mocks(self)
      allow_any_instance_of(InvoiceItemRepository).to receive(:create_invoice_items).and_return(mock_invoice_items)
      mock_customers = Mockable.mock_generator(self, 'Customer', customer_hashes)
      allow_any_instance_of(CustomerRepository).to receive(:create_customers).and_return(mock_customers)
      files = { items: './file1.csv', merchants: './file2.csv', invoices: './file3.csv', transactions: './file4.csv', invoice_items: './file5.csv', customers: './file6.csv' }
      sales_engine = SalesEngine.from_csv(files)

      item_repo = sales_engine.items
      expect(item_repo.items.first).is_a? Item
    end
  end

  describe '#merchants' do
    it 'has an MerchantRepository' do
      mock_items = ItemMocks.items_as_mocks(self)
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_items)
      mock_merchants = MerchantMocks.merchants_as_mocks(self)
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_merchants)
      mock_invoices = InvoiceMocks.invoices_as_mocks(self)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_invoices)
      mock_transactions = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_transactions)
      mock_invoice_items = InvoiceItemMocks.invoice_items_as_mocks(self)
      allow_any_instance_of(InvoiceItemRepository).to receive(:create_invoice_items).and_return(mock_invoice_items)
      mock_customers = Mockable.mock_generator(self, 'Customer', customer_hashes)
      allow_any_instance_of(CustomerRepository).to receive(:create_customers).and_return(mock_customers)
      files = { items: './file1.csv', merchants: './file2.csv', invoices: './file3.csv', transactions: './file4.csv', invoice_items: './file5.csv', customers: './file6.csv' }
      sales_engine = SalesEngine.from_csv(files)

      expect(sales_engine.merchants).is_a? MerchantRepository
    end

    it 'has Merchants in the MerchantRepository' do
      mock_items = ItemMocks.items_as_mocks(self)
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_items)
      mock_merchants = MerchantMocks.merchants_as_mocks(self)
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_merchants)
      mock_invoices = InvoiceMocks.invoices_as_mocks(self)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_invoices)
      mock_transactions = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_transactions)
      mock_invoice_items = InvoiceItemMocks.invoice_items_as_mocks(self)
      allow_any_instance_of(InvoiceItemRepository).to receive(:create_invoice_items).and_return(mock_invoice_items)
      mock_customers = Mockable.mock_generator(self, 'Customer', customer_hashes)
      allow_any_instance_of(CustomerRepository).to receive(:create_customers).and_return(mock_customers)
      files = { items: './file1.csv', merchants: './file2.csv', invoices: './file3.csv', transactions: './file4.csv', invoice_items: './file5.csv', customers: './file6.csv' }
      sales_engine = SalesEngine.from_csv(files)

      merchant_repo = sales_engine.merchants
      expect(merchant_repo.merchants.first).is_a? Merchant
    end
  end

  describe '#invoices' do
    it 'has an InvoiceRepository' do
      mock_items = ItemMocks.items_as_mocks(self)
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_items)
      mock_merchants = MerchantMocks.merchants_as_mocks(self)
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_merchants)
      mock_invoices = InvoiceMocks.invoices_as_mocks(self)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_invoices)
      mock_transactions = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_transactions)
      mock_invoice_items = InvoiceItemMocks.invoice_items_as_mocks(self)
      allow_any_instance_of(InvoiceItemRepository).to receive(:create_invoice_items).and_return(mock_invoice_items)
      mock_customers = Mockable.mock_generator(self, 'Customer', customer_hashes)
      allow_any_instance_of(CustomerRepository).to receive(:create_customers).and_return(mock_customers)
      files = { items: './file1.csv', merchants: './file2.csv', invoices: './file3.csv', transactions: './file4.csv', invoice_items: './file5.csv', customers: './file6.csv' }
      sales_engine = SalesEngine.from_csv(files)

      expect(sales_engine.invoices).is_a? InvoiceRepository
    end

    it 'has Invoices in the InvoiceRepository' do
      mock_items = ItemMocks.items_as_mocks(self)
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_items)
      mock_merchants = MerchantMocks.merchants_as_mocks(self)
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_merchants)
      mock_invoices = InvoiceMocks.invoices_as_mocks(self)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_invoices)
      mock_transactions = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_transactions)
      mock_invoice_items = InvoiceItemMocks.invoice_items_as_mocks(self)
      allow_any_instance_of(InvoiceItemRepository).to receive(:create_invoice_items).and_return(mock_invoice_items)
      mock_customers = Mockable.mock_generator(self, 'Customer', customer_hashes)
      allow_any_instance_of(CustomerRepository).to receive(:create_customers).and_return(mock_customers)
      files = { items: './file1.csv', merchants: './file2.csv', invoices: './file3.csv', transactions: './file4.csv', invoice_items: './file5.csv', customers: './file6.csv' }
      sales_engine = SalesEngine.from_csv(files)

      invoice_repo = sales_engine.invoices
      expect(invoice_repo.invoices.first).is_a? Invoice
    end
  end

  describe '#transactions' do
    it 'has an TransactionRepository' do
      mock_items = ItemMocks.items_as_mocks(self)
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_items)
      mock_merchants = MerchantMocks.merchants_as_mocks(self)
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_merchants)
      mock_invoices = InvoiceMocks.invoices_as_mocks(self)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_invoices)
      mock_transactions = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_transactions)
      mock_invoice_items = InvoiceItemMocks.invoice_items_as_mocks(self)
      allow_any_instance_of(InvoiceItemRepository).to receive(:create_invoice_items).and_return(mock_invoice_items)
      mock_customers = Mockable.mock_generator(self, 'Customer', customer_hashes)
      allow_any_instance_of(CustomerRepository).to receive(:create_customers).and_return(mock_customers)
      files = { items: './file1.csv', merchants: './file2.csv', invoices: './file3.csv', transactions: './file4.csv', invoice_items: './file5.csv', customers: './file6.csv' }
      sales_engine = SalesEngine.from_csv(files)

      expect(sales_engine.invoices).is_a? InvoiceRepository
    end

    it 'has Transactions in the TransactionRepository' do
      mock_items = ItemMocks.items_as_mocks(self)
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_items)
      mock_merchants = MerchantMocks.merchants_as_mocks(self)
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_merchants)
      mock_invoices = InvoiceMocks.invoices_as_mocks(self)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_invoices)
      mock_transactions = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_transactions)
      mock_invoice_items = InvoiceItemMocks.invoice_items_as_mocks(self)
      allow_any_instance_of(InvoiceItemRepository).to receive(:create_invoice_items).and_return(mock_invoice_items)
      mock_customers = Mockable.mock_generator(self, 'Customer', customer_hashes)
      allow_any_instance_of(CustomerRepository).to receive(:create_customers).and_return(mock_customers)
      files = { items: './file1.csv', merchants: './file2.csv', invoices: './file3.csv', transactions: './file4.csv', invoice_items: './file5.csv', customers: './file6.csv' }
      sales_engine = SalesEngine.from_csv(files)

      transaction_repo = sales_engine.transactions
      expect(transaction_repo.transactions.first).is_a? Transaction
    end
  end

  describe '#invoice_items' do
    it 'has an InvoiceItemRepository' do
      mock_items = ItemMocks.items_as_mocks(self)
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_items)
      mock_merchants = MerchantMocks.merchants_as_mocks(self)
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_merchants)
      mock_invoices = InvoiceMocks.invoices_as_mocks(self)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_invoices)
      mock_transactions = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_transactions)
      mock_invoice_items = InvoiceItemMocks.invoice_items_as_mocks(self)
      allow_any_instance_of(InvoiceItemRepository).to receive(:create_invoice_items).and_return(mock_invoice_items)
      mock_customers = Mockable.mock_generator(self, 'Customer', customer_hashes)
      allow_any_instance_of(CustomerRepository).to receive(:create_customers).and_return(mock_customers)
      files = { items: './file1.csv', merchants: './file2.csv', invoices: './file3.csv', transactions: './file4.csv', invoice_items: './file5.csv', customers: './file6.csv' }
      sales_engine = SalesEngine.from_csv(files)

      invoice_item_repo = sales_engine.invoice_items
      expect(invoice_item_repo).is_a? InvoiceItemRepository
    end

    it 'has invoice items' do
      mock_items = ItemMocks.items_as_mocks(self)
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_items)
      mock_merchants = MerchantMocks.merchants_as_mocks(self)
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_merchants)
      mock_invoices = InvoiceMocks.invoices_as_mocks(self)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_invoices)
      mock_transactions = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_transactions)
      mock_invoice_items = InvoiceItemMocks.invoice_items_as_mocks(self)
      allow_any_instance_of(InvoiceItemRepository).to receive(:create_invoice_items).and_return(mock_invoice_items)
      mock_customers = Mockable.mock_generator(self, 'Customer', customer_hashes)
      allow_any_instance_of(CustomerRepository).to receive(:create_customers).and_return(mock_customers)
      files = { items: './file1.csv', merchants: './file2.csv', invoices: './file3.csv', transactions: './file4.csv', invoice_items: './file5.csv', customers: './file6.csv' }
      sales_engine = SalesEngine.from_csv(files)

      invoice_item_repo = sales_engine.invoice_items
      expect(invoice_item_repo.invoice_items.first).is_a? InvoiceItem 
    end
  end

  describe '#customers' do
    it 'has a CustomerRepository' do
      mock_items = ItemMocks.items_as_mocks(self)
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_items)
      mock_merchants = MerchantMocks.merchants_as_mocks(self)
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_merchants)
      mock_invoices = InvoiceMocks.invoices_as_mocks(self)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_invoices)
      mock_transactions = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_transactions)
      mock_invoice_items = InvoiceItemMocks.invoice_items_as_mocks(self)
      allow_any_instance_of(InvoiceItemRepository).to receive(:create_invoice_items).and_return(mock_invoice_items)
      mock_customers = Mockable.mock_generator(self, 'Customer', customer_hashes)
      allow_any_instance_of(CustomerRepository).to receive(:create_customers).and_return(mock_customers)
      files = { items: './file1.csv', merchants: './file2.csv', invoices: './file3.csv', transactions: './file4.csv', invoice_items: './file5.csv', customers: './file6.csv' }
      sales_engine = SalesEngine.from_csv(files)

      customer_repo = sales_engine.customers
      expect(customer_repo).is_a? CustomerRepository
    end

    it 'has customers' do
      mock_items = ItemMocks.items_as_mocks(self)
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_items)
      mock_merchants = MerchantMocks.merchants_as_mocks(self)
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_merchants)
      mock_invoices = InvoiceMocks.invoices_as_mocks(self)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_invoices)
      mock_transactions = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_transactions)
      mock_invoice_items = InvoiceItemMocks.invoice_items_as_mocks(self)
      allow_any_instance_of(InvoiceItemRepository).to receive(:create_invoice_items).and_return(mock_invoice_items)
      mock_customers = Mockable.mock_generator(self, 'Customer', customer_hashes)
      allow_any_instance_of(CustomerRepository).to receive(:create_customers).and_return(mock_customers)
      files = { items: './file1.csv', merchants: './file2.csv', invoices: './file3.csv', transactions: './file4.csv', invoice_items: './file5.csv', customers: './file6.csv' }
      sales_engine = SalesEngine.from_csv(files)

      customer_repo = sales_engine.customers
      expect(customer_repo.customers.first).is_a? Customer
    end
  end


  describe '#analyst' do
    it 'returns a new instance of SalesAnalyst' do
      mock_items = ItemMocks.items_as_mocks(self)
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_items)
      mock_merchants = MerchantMocks.merchants_as_mocks(self)
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_merchants)
      mock_invoices = InvoiceMocks.invoices_as_mocks(self)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_invoices)
      mock_transactions = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_transactions)
      mock_invoice_items = InvoiceItemMocks.invoice_items_as_mocks(self)
      allow_any_instance_of(InvoiceItemRepository).to receive(:create_invoice_items).and_return(mock_invoice_items)
      mock_customers = Mockable.mock_generator(self, 'Customer', customer_hashes)
      allow_any_instance_of(CustomerRepository).to receive(:create_customers).and_return(mock_customers)
      files = { items: './file1.csv', merchants: './file2.csv', invoices: './file3.csv', transactions: './file4.csv', invoice_items: './file5.csv', customers: './file6.csv' }
      sales_engine = SalesEngine.from_csv(files)

      sales_analyst = sales_engine.analyst
      expect(sales_analyst).to be_instance_of SalesAnalyst
    end
  end
end

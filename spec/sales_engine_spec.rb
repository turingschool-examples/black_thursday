require 'CSV'
require 'rspec'

require './data/item_mocks'
require './data/merchant_mocks'
require './lib/file_io'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/sales_engine'
require './lib/sales_analyst'

describe SalesEngine do
  describe '#from_csv' do
    it 'creates a new instance of SalesEngine' do
      mock_items = ItemMocks.items_as_mocks(self)
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_items)
      mock_merchants = MerchantMocks.merchants_as_mocks(self)
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_merchants)
      mock_invoices = InvoiceMocks.invoices_as_mocks(self)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_invoices)
      files = { items: './file1.csv', merchants: './file2.csv', invoices: './file3.csv' }
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
      files = { items: './file1.csv', merchants: './file2.csv', invoices: './file3.csv' }
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
      files = { items: './file1.csv', merchants: './file2.csv', invoices: './file3.csv' }
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
      files = { items: './file1.csv', merchants: './file2.csv', invoices: './file3.csv' }
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
      files = { items: './file1.csv', merchants: './file2.csv', invoices: './file3.csv' }
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
      files = { items: './file1.csv', merchants: './file2.csv', invoices: './file3.csv' }
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
      files = { items: './file1.csv', merchants: './file2.csv', invoices: './file3.csv' }
      sales_engine = SalesEngine.from_csv(files)

      invoice_repo = sales_engine.invoices
      expect(invoice_repo.invoices.first).is_a? Invoice
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
      files = { items: './file1.csv', merchants: './file2.csv', invoices: './file3.csv' }
      sales_engine = SalesEngine.from_csv(files)

      sales_analyst = sales_engine.analyst
      expect(sales_analyst).to be_instance_of SalesAnalyst
    end
  end
end

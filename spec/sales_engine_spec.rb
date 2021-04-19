require 'csv'
require 'rspec'

require './data/customer_mocks'
require './data/invoice_mocks'
require './data/invoice_item_mocks'
require './data/item_mocks'
require './data/transaction_mocks'
require './data/merchant_mocks'

require './lib/customer'
require './lib/file_io'
require './lib/invoice'
require './lib/invoice_item'
require './lib/item'
require './lib/merchant'
require './lib/sales_engine'
require './lib/sales_analyst'
require './lib/transaction'

require './spec/sales_engine_mocks'

describe SalesEngine do
  describe '#from_csv' do
    it 'creates a new instance of SalesEngine' do
      sales_engine = SalesEngineMocks.sales_engine(self)

      expect(sales_engine).to be_a SalesEngine
    end
  end

  describe '#items' do
    it 'has an ItemRepository' do
      sales_engine = SalesEngineMocks.sales_engine(self)

      expect(sales_engine.items).to be_an ItemRepository
    end

    it 'has Items in the ItemRepository' do
      sales_engine = SalesEngineMocks.sales_engine(self)

      item_repo = sales_engine.items
      expect(item_repo.all).not_to eq []
    end
  end

  describe '#merchants' do
    it 'has an MerchantRepository' do
      sales_engine = SalesEngineMocks.sales_engine(self)

      expect(sales_engine.merchants).to be_a MerchantRepository
    end

    it 'has Merchants in the MerchantRepository' do
      sales_engine = SalesEngineMocks.sales_engine(self)
      merchant_repo = sales_engine.merchants

      expect(merchant_repo.all).not_to eq []
    end
  end

  describe '#invoices' do
    it 'has an InvoiceRepository' do
      sales_engine = SalesEngineMocks.sales_engine(self)

      expect(sales_engine.invoices).to be_an InvoiceRepository
    end

    it 'has Invoices in the InvoiceRepository' do
      sales_engine = SalesEngineMocks.sales_engine(self)
      invoice_repo = sales_engine.invoices

      expect(invoice_repo.all).not_to eq []
    end
  end

  describe '#transactions' do
    it 'has an TransactionRepository' do
      sales_engine = SalesEngineMocks.sales_engine(self)

      expect(sales_engine.invoices).to be_an InvoiceRepository
    end

    it 'has Transactions in the TransactionRepository' do
      sales_engine = SalesEngineMocks.sales_engine(self)
      transaction_repo = sales_engine.transactions

      expect(transaction_repo.all).not_to eq []
    end
  end

  describe '#invoice_items' do
    it 'has an InvoiceItemRepository' do
      sales_engine = SalesEngineMocks.sales_engine(self)
      invoice_item_repo = sales_engine.invoice_items

      expect(invoice_item_repo).to be_an InvoiceItemRepository
    end

    it 'has invoice items' do
      sales_engine = SalesEngineMocks.sales_engine(self)
      invoice_item_repo = sales_engine.invoice_items

      expect(invoice_item_repo.all).not_to eq []
    end
  end

  describe '#customers' do
    it 'has a CustomerRepository' do
      sales_engine = SalesEngineMocks.sales_engine(self)
      customer_repo = sales_engine.customers

      expect(customer_repo).to be_a CustomerRepository
    end

    it 'has customers' do
      sales_engine = SalesEngineMocks.sales_engine(self)
      customer_repo = sales_engine.customers

      expect(customer_repo.all).not_to eq []
    end
  end

  describe '#analyst' do
    it 'returns a new instance of SalesAnalyst' do
      sales_engine = SalesEngineMocks.sales_engine(self)
      sales_analyst = sales_engine.analyst

      expect(sales_analyst).to be_a SalesAnalyst
    end
  end
end

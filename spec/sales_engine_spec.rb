# frozen_string_literal: true

require 'rspec'
require 'csv'
require './lib/sales_engine'
require './lib/merchant_repository'

describe SalesEngine do
  let(:data) do
    {
      items: './data/items_test.csv',
      merchants: './data/merchants_test.csv',
      invoice_items: './data/invoice_items_test.csv',
      invoices: './data/invoices_test.csv',
      transactions: './data/transactions_test.csv',
      customers: './data/customer_test.csv'
    }
  end

  describe '#initialize' do
    it 'instantiates correctly' do
      se = SalesEngine.new(data)

      expect(se).to be_a SalesEngine
    end
  end

  describe '#self.from_csv' do
    it 'initializes a SalesEngine with data from a hash of CSV file locations' do
      se = SalesEngine.from_csv(data)
      expect(se).to be_a SalesEngine
      expect(se.items).to be_a ItemRepository
      expect(se.merchants).to be_a MerchantRepository
      expect(se.invoice_items).to be_a InvoiceItemRepository
      expect(se.invoices).to be_a InvoiceRepo
      expect(se.transactions).to be_a TransactionRepo
      expect(se.customers).to be_a CustomerRepo
      # expect(se.analyst).to be_a SalesAnalyst
    end
  end

  describe '#average_items_per_merchant' do
    it 'returns the average_items_per_merchant' do
      se = SalesEngine.from_csv(data)
      expect(se.average_items_per_merchant).to eq(0.25)
    end
  end
end

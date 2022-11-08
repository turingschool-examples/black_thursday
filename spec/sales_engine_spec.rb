# frozen_string_literal: true

require 'rspec'
require 'csv'
require './lib/sales_engine'
require './lib/merchant_repository'
require './lib/sales_analyst'

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
      expect(se.analyst).to be_a SalesAnalyst
    end
  end

  describe '#send_to_repo' do
    it 'passes a message to the repo' do
      se = SalesEngine.from_csv(data)
      expect(se.send_to_repo(method: :average_items_per_merchant).round(2)).to eq(0.25)
      expect(se.send_to_repo(method: :invoice_total, args: 1, destination: 'invoices')).to eq(5636.63)
    end
  end
end

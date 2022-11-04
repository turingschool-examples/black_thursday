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
  # let(:se) { SalesEngine.new(data) }

  describe '#initialize' do
    it 'instantiates correctly' do
      i_data = CSV.read './data/items_test.csv', headers: true, header_converters: :symbol
      m_data = CSV.read './data/merchants_test.csv', headers: true, header_converters: :symbol
      ii_data = CSV.read './data/invoice_items_test.csv', headers: true, header_converters: :symbol
      inv_data = CSV.read './data/invoices_test.csv', headers: true, header_converters: :symbol
      t_data = CSV.read './data/transactions_test.csv', headers: true, header_converters: :symbol
      c_data = CSV.read './data/customer_test.csv', headers: true, header_converters: :symbol
      se = SalesEngine.new(i_data, m_data, ii_data, inv_data, t_data, c_data)

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
    end
  end
end

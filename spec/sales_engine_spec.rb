# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require 'rspec'
require './lib/sales_engine'

require 'csv'
describe SalesEngine do
  describe '.from_csv' do
    it 'creates an instance of DataRepository' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        transactions: './data/invoices.csv',
        invoice_items: './data/invoice_items.csv'
      )
      expect(se).to be_an_instance_of(SalesEngine)
    end
  end

  describe '#items' do
    it 'returns a new instance of ItemRepository with an array of item objects' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        transactions: './data/invoices.csv',
        invoice_items: './data/invoice_items.csv'
      )
      ir = se.items

      expect(ir).to be_an_instance_of(ItemRepository)
    end

    it 'returns a new instance of MerchantRepository with an array of merchant objects' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        transactions: './data/invoices.csv',
        invoice_items: './data/invoice_items.csv'
      )
      mr = se.merchants

      expect(mr).to be_an_instance_of(MerchantsRepository)
    end

    it 'returns an instance of InvoiceRepository with an array of invoice objects' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        transactions: './data/invoices.csv',
        invoice_items: './data/invoice_items.csv'
      )
      ir = se.invoices

      expect(ir).to be_an_instance_of(InvoiceRepository)
    end

    it 'can find an invoice by id' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        transactions: './data/invoices.csv',
        invoice_items: './data/invoice_items.csv'
      )

      expect(se.invoices.find_by_id(6)).to be_an_instance_of(Invoice)
    end
  end
end

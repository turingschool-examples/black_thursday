# frozen_string_literal: true

require_relative 'simplecov'
SimpleCov.start
require_relative 'rspec'
require_relative './lib/sales_engine'
require_relative './lib/merchant'
require_relative './lib/merchants_repository'
require_relative './lib/items'
require_relative './lib/item_repository'
require_relative './lib/sales_analyst'
require_relative './lib/invoice_repository'
require_relative './lib/invoice'
require_relative './lib/data_repository'
require_relative 'csv'
describe DataRepository do
  describe '#initialize' do
    it 'creates an instance of DataRepository' do
      dr = DataRepository.new(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv'
      )

      expect(dr).to be_an_instance_of(DataRepository)
    end

    it 'has readable_attributes' do
      dr = DataRepository.new(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv'
      )

      expect(dr.items).to be_an_instance_of(ItemRepository)
      expect(dr.merchants).to be_an_instance_of(MerchantsRepository)
      expect(dr.invoices).to be_an_instance_of(InvoiceRepository)
    end
  end
end

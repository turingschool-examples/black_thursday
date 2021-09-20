# frozen_string_literal: true

'require relative'
require 'rspec'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchants_repository'
require './lib/items'
require './lib/item_repository'
require './lib/sales_analyst'
require './lib/invoice_repository'
require './lib/invoice'
require './lib/data_repository'
require 'csv'
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

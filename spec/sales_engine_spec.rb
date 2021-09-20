# frozen_string_literal: true

'require_relative'
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
describe SalesEngine do
  describe '.from_csv' do
    it 'creates an instance of DataRepository' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
                               )
      expect(se).to be_an_instance_of(DataRepository)
    end

    it 'returns a new instance of ItemRepository with an array of item objects' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
                               )
      ir = se.items

      expect(ir).to be_an_instance_of(ItemRepository)
    end

    it 'returns a new instance of MerchantRepository with an array of merchant objects' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
                               )
      mr = se.merchants

      expect(mr).to be_an_instance_of(MerchantsRepository)
    end
  end

  describe '#analyst' do
    it 'creates a new instance of SalesAnalyst' do
      se = SalesEngine.new(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
                          )
      analyst = se.analyst(se.items, se.merchants)

      expect(analyst).to be_a(SalesAnalyst)
    end
  end

  describe '.from_csv' do
    it 'creates an instance of InvoiceRepository' do
      se = SalesEngine.from_csv(invoices: './data/invoices.csv')

      expect(se).to be_an_instance_of(DataRepository)
    end

    it 'can find an invoice by id' do
      se = SalesEngine.from_csv(invoices: './data/invoices.csv')

      expect(se.invoices.find_by_id(6)).to be_an_instance_of(Invoice)
    end
  end
end

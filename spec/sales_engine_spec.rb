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
        merchants: './data/merchants.csv'
      )
      expect(se).to be_an_instance_of(DataRepository)
    end

  describe '#items' do
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

end

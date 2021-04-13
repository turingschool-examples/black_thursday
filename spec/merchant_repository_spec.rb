require 'SimpleCOV'
require 'csv'
require './lib/sales_engine'
require './lib/merchant_repository'

RSpec.describe MerchantRepository do
  describe 'Instance' do
    it 'exists' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv')

      mr = se.merchants

      expect(mr).to be_an_instance_og(MerchantRepository)
    end
  end

  describe '#all' do
    it 'returns an array of all merchant instances' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv')

      mr = se.merchants

      expect(mr.all[0].id).to eq('12334105')
    end
  end

  describe '#find_by_id' do
    it 'finds merchant by id' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv')

      mr = se.merchants


    expect(mr.find_by_id('12335573').name).to eq('retropostershop')
    end

    it 'returns nil if no id' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv')

      mr = se.merchants

      expect(mr.find_by_id('2113113113')).to eq(nil)
    end
  end
end

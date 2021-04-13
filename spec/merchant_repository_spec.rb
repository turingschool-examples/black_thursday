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

      merchant_1 = Merchant.new({
                    id: '12334105',
                    name: 'Shopin1901',
                    created_at:	'2010-12-10',
                    updated_at:	'2011-12-04'
        })

      expect(mr.all[0]).to eq(merchant_1)
    end
  end

  it 'finds merchant by id' do
    mr = MerchantRepository.new

    expect(mr.find_by_id(1175)).to eq()
  end
end

require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/merchant_repository'

RSpec.describe Merchant do
  describe '#initialize' do
    it 'exists' do
      mock_merchant_repo = instance_double('MerchantRepository')
      merchant = Merchant.new({
                              id: '12334105',
                              name: 'Shopin1901',
                              created_at: '2010-12-10',
                              updated_at: '2011-12-04'
                              }, mock_merchant_repo)

      expect(merchant).to be_a(Merchant)
    end

    it 'has attributes' do
      mock_merchant_repo = instance_double('MerchantRepository')
      merchant = Merchant.new({
                              id: '12334105',
                              name: 'Shopin1901',
                              created_at: '2010-12-10',
                              updated_at: '2011-12-04'
                              }, mock_merchant_repo)

      expect(merchant.id).to eq(12334105)
      expect(merchant.name).to eq('Shopin1901')
      expect(merchant.created_at.year).to eq(2010)
      expect(merchant.updated_at.year).to eq(2011)
    end
  end

  describe '#update_name' do
    it 'updates name with givin attributes' do
      mock_merchant_repo = instance_double('MerchantRepository')
      merchant = Merchant.new({
                              id: '12334105',
                              name: 'Shopin1901',
                              created_at: '2010-12-10',
                              updated_at: '2011-12-04'
                              }, mock_merchant_repo)

      expect(merchant.name).to eq('Shopin1901')
      merchant.update(name: 'Jimmy')
      expect(merchant.name).to eq('Jimmy')
    end
  end

  describe '#update_time_stamp' do
    it 'can update updated_at time stamp' do
      mock_merchant_repo = instance_double('MerchantRepository')
      merchant = Merchant.new({
                              id: '12334105',
                              name: 'Shopin1901',
                              created_at: '2010-12-10',
                              updated_at: '2011-12-04'
                              }, mock_merchant_repo)

      expect(merchant.updated_at.year).to eq(2011)
      merchant.update_time_stamp
      expect(merchant.updated_at.year).to eq(2021)
    end
  end

  describe '#update' do
    it 'can update the entire merchant object' do
      mock_merchant_repo = instance_double('MerchantRepository')
      merchant = Merchant.new({
                              id: '12334105',
                              name: 'Shopin1901',
                              created_at: '2010-12-10',
                              updated_at: '2011-12-04'
                              }, mock_merchant_repo)

      expect(merchant.name).to eq('Shopin1901')
      expect(merchant.updated_at.year).to eq(2011)
      merchant.update(name: 'Jimmy')
      expect(merchant.name).to eq('Jimmy')
      expect(merchant.updated_at.year).to eq(2021)
    end
  end
end
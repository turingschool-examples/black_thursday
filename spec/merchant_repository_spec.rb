require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/merchant_repository'

RSpec.describe MerchantRepository do
  describe '#initialize' do
    it 'exists' do
      mock_sales_engine = instance_double('SalesEngine')
      mr = MerchantRepository.new('./spec/truncated_data/merchants_truncated.csv', mock_sales_engine)

      expect(mr).to be_instance_of(MerchantRepository)
    end

    it 'has merchants' do
      mock_sales_engine = instance_double('SalesEngine')
      mr = MerchantRepository.new('./spec/truncated_data/merchants_truncated.csv', mock_sales_engine)

      expect(mr.merchants[0]).to be_a(Merchant)
    end
  end

  describe '#all' do
    it 'returns all merchants' do
      mock_sales_engine = instance_double('SalesEngine')
      mr = MerchantRepository.new('./spec/truncated_data/merchants_truncated.csv', mock_sales_engine)

      expect(mr.all).to be_a(Array)
      expect(mr.all.count).to eq(4)
      expect(mr.all[0]).to be_a(Merchant)
    end
  end

  describe '#find_by_id' do
    it 'finds by id or returns nil' do
      mock_sales_engine = instance_double('SalesEngine')
      mr = MerchantRepository.new('./spec/truncated_data/merchants_truncated.csv', mock_sales_engine)

      expect(mr.find_by_id(3)).to eq(nil)
      expect(mr.find_by_id(12334105)).to eq(mr.merchants[0])
    end
  end

  describe '#find_by_name' do
    it 'finds by name or returns nil' do
      mock_sales_engine = instance_double('SalesEngine')
      mr = MerchantRepository.new('./spec/truncated_data/merchants_truncated.csv', mock_sales_engine)

      expect(mr.find_by_name('JimmysSubs')).to eq(nil)
      expect(mr.find_by_name('Shopin1901')).to eq(mr.merchants[0])
    end
  end

  describe '#find_all_by_name' do
    it 'finds all names containing fragment or empty array' do
      mock_sales_engine = instance_double('SalesEngine')
      mr = MerchantRepository.new('./spec/truncated_data/merchants_truncated.csv', mock_sales_engine)

      expect(mr.find_all_by_name('Rtpdsfsd')).to eq([])
      expect(mr.find_all_by_name('Can')).to eq([mr.merchants[1]])
      expect(mr.find_all_by_name('Min')).to eq([mr.merchants[2], mr.merchants[3]])
    end
  end

  describe '#create' do
    it 'can create new merchant' do
      mock_sales_engine = instance_double('SalesEngine')
      mr = MerchantRepository.new('./spec/truncated_data/merchants_truncated.csv', mock_sales_engine)

      mr.create({
                  name: 'JimmysSubs',
                  created_at: Time.now.to_s,
                  updated_at: Time.now.to_s
                })

      expect(mr.find_by_id(12334114)).to eq(mr.merchants[4])
    end
  end

  describe '#update' do
    it 'can update merchants name' do
      mock_sales_engine = instance_double('SalesEngine')
      mr = MerchantRepository.new('./spec/truncated_data/merchants_truncated.csv', mock_sales_engine)

      mr.update(12334105, {name: 'ShopinShopinShopin'})

      expect(mr.merchants[0].name).to eq('ShopinShopinShopin')
      expect(mr.find_by_name('Shopin1901')).to eq(nil)
    end
  end

  describe '#delete' do
    it 'can delete merchant object' do
      mock_sales_engine = instance_double('SalesEngine')
      mr = MerchantRepository.new('./spec/truncated_data/merchants_truncated.csv', mock_sales_engine)

      mr.delete(12334105)

      expect(mr.find_by_id(12334105)).to eq(nil)
    end
  end
end

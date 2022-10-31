require './lib/merchant_repository'
require './lib/merchant'

RSpec.describe MerchantRepository do
  describe '#initialize' do
    it 'exists' do
      merchant_1 = Merchant.new({:id => 1,
                                 :name => "Nike"})
      merchant_2 = Merchant.new({:id => 2,
                                 :name => "Addidas"})
      merchants = [merchant_1, merchant_2]
      merchant_repository = MerchantRepository.new(merchants)

      expect(merchant_repository).to be_a(MerchantRepository)
    end
  end

  describe '#all' do
    it 'returns an array of all known merchants' do
      merchant_1 = Merchant.new({:id => 1,
                                 :name => "Nike"})
      merchant_2 = Merchant.new({:id => 2,
                                 :name => "Addidas"})
      merchants = [merchant_1, merchant_2]
      merchant_repository = MerchantRepository.new(merchants)

      expect(merchant_repository.all).to eq([merchant_1, merchant_2])
    end
  end

  describe '#find_by_id' do
    it 'finds and returns a merchant object by id' do
      merchant_1 = Merchant.new({:id => 1,
                                 :name => "Nike"})
      merchant_2 = Merchant.new({:id => 2,
                                 :name => "Addidas"})
      merchants = [merchant_1, merchant_2]
      merchant_repository = MerchantRepository.new(merchants)

      expect(merchant_repository.find_by_id(1)).to eq(merchant_1)
    end
  end
end

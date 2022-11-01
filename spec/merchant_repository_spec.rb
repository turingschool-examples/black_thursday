require 'rspec'
require './lib/merchant'
require './lib/merchant_repository'

describe MerchantRepository do
  let!(:merchant_repository) {MerchantRepository.new}
  it 'exists' do
    expect(merchant_repository).to be_a MerchantRepository
  end

  it 'returns an array of known merchant instances' do
    merchant_1 = Merchant.new({:id => 6, :name => "Walmart"})
    merchant_2 = Merchant.new({:id => 7, :name => "Target"})

    expect(merchant_repository.all).to eq([])

    merchant_repository.add_merchant_to_repo(merchant_1)

    expect(merchant_repository.all).to eq([merchant_1])

    merchant_repository.add_merchant_to_repo(merchant_2)

    expect(merchant_repository.all).to eq([merchant_1, merchant_2])
  end

  describe '#find_by_id' do
    it 'returns either nil or an instance of merchant with the matching ID' do
      merchant_1 = Merchant.new({:id => 6, :name => "Walmart"})
      merchant_2 = Merchant.new({:id => 7, :name => "Target"})
      merchant_repository.add_merchant_to_repo(merchant_1)
      merchant_repository.add_merchant_to_repo(merchant_2)


      expect(merchant_repository.find_by_id(10)).to eq(nil)
      expect(merchant_repository.find_by_id(6)).to eq(merchant_1)
      expect(merchant_repository.find_by_id(7)).to eq(merchant_2)
    end
  end
end

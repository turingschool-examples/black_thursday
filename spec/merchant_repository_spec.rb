require './lib/merchant.rb'
require './lib/merchant_repository.rb'

RSpec.describe MerchantRepository do
  it 'exists' do
    merchant_repo = MerchantRepository.new('./data/merchants.csv')
    expect(merchant_repo).to be_a(MerchantRepository)
  end

  it 'returns an array of all known Merchant instances' do
    merchant_repo = MerchantRepository.new('./data/merchants.csv')
    expect(merchant_repo.all.count).to eq(475)
  end

  it 'can find merchant by ID' do
    merchant_repo = MerchantRepository.new('./data/merchants.csv')
    id = 12334105
    expect(merchant_repo.find_by_id).to eq('Shopin1901')
  end
end

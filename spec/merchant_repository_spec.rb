require './lib/merchant.rb'
require './lib/merchant_repository.rb'

RSpec.describe MerchantRepository do
  it 'exists' do
    merchant_repo = MerchantRepository.new('./data/merchants.csv')
    expect(merchant_repo).to be_a(MerchantRepository)
  end

  it 'returns an array of all known Merchant instances' do
    merchant_repo = MerchantRepository.new('./data/merchants.csv')
    expect(merchant_repo.all).to eq([])
    merchant = Merchant.new({:id => 1, :name => "Bob's Burgers"})
    expect(merchant_repo.all).to eq([merchant])
    
  end

end

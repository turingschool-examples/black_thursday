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
end

require './lib/merchant'
require './lib/merchant_repository'

RSpec.describe MerchantRepository do
  it 'exists' do
    merch_repo = MerchantRepository.new

    expect(merch_repo).to be_a(MerchantRepository)
  end

  it 'stores merchants, empty by default' do
    merch_repo = MerchantRepository.new

    expect(merch_repo.merchants).to eq([])
  end
end
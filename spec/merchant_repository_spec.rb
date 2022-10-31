require './lib/merchant_repository'

RSpec.describe MerchantRepository do
  it 'exists' do
    mr = MerchantRepository.new

    expect(mr).to be_a(MerchantRepository)
  end

  it 'can have merchants' do
    mr = MerchantRepository.new
    m = Merchant.new({id: 5, name: "Turing School"})
    mr.add(m)

    expect(mr.merchants).to eq([m])
  end
end

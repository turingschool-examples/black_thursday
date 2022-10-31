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

  it 'can list an array of all merchants' do
    mr = MerchantRepository.new
    m = Merchant.new({id: 5, name: "Turing School"})
    m2 = Merchant.new({id: 4, name: "Porsche"})
    mr.add(m)
    mr.add(m2)

    expect(mr.all).to eq([m, m2])
  end

  it 'can find a specific merchant by id' do
    mr = MerchantRepository.new
    m = Merchant.new({id: 5, name: "Turing School"})
    m2 = Merchant.new({id: 4, name: "Porsche"})
    mr.add(m)
    mr.add(m2)

    expect(mr.find_by_id(4)).to eq(m2)
  end

  it 'can find a specific merchant by name' do
    mr = MerchantRepository.new
    m = Merchant.new({id: 5, name: "Turing School"})
    m2 = Merchant.new({id: 4, name: "Porsche"})
    mr.add(m)
    mr.add(m2)

    expect(mr.find_by_name("Porsche")).to eq(m2)
  end
end

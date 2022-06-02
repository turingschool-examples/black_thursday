require './test/spec_helper'


RSpec.describe MerchantRepository do

  before :each do
    @merchantrepository= MerchantRepository.new("./data/merchants.csv")
  end

  it 'exists' do

    expect(@merchantrepository).to be_a(MerchantRepository)
  end

  it 'returns an array of all known merchants' do

    expect(@merchantrepository.all.class).to eq(Array)
    expect(@merchantrepository.all[0].class).to eq(Merchant)
    expect(@merchantrepository.all.count).to eq(475)
  end

  it 'returns either nil or an instance of Merchant with a matching ID' do

    expect(@merchantrepository.find_by_id(12334132).name).to eq("perlesemoi")
    expect(@merchantrepository.find_by_id(123456)).to eq(nil)
    expect(@merchantrepository.find_by_id(12334132)).to be_a(Merchant)

  end

  it 'returns either nil or an instance of Merchant with a name' do

    expect(@merchantrepository.find_by_name("MiniatureBikez")).to be_a(Merchant)
    expect(@merchantrepository.find_by_name("AndreBikez")).to eq(nil)

  end

end

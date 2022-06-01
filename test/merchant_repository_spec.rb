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


end

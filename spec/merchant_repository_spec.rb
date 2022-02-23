require 'csv'
require './lib/merchant'
require './lib/merchant_repository'

describe MerchantRepository do
  merch_rep = MerchantRepository.new('./data/merchants.csv')

  it "exists" do
    expect(merch_rep).to be_an_instance_of(MerchantRepository)
  end

  it "can call all Merchant class instances" do
    expect(merch_rep.all.length).to eq(475)
    expect(merch_rep.all[3].class).to be(Merchant)
  end
end

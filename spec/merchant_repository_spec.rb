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

  it "can find an instance of Merchant using it's ID" do
    expect(merch_rep.find_by_id('12334319')).to eq(merch_rep.all[55])
    expect(merch_rep.find_by_id('12334189')).to eq(merch_rep.all[20])
    expect(merch_rep.find_by_id('nothing')).to be_nil
  end

  it "can find an instance of Merchant using it's name" do
    expect(merch_rep.find_by_name('GJGemology')).to eq(merch_rep.all[26])
    expect(merch_rep.find_by_name('SWISSIonenSchmuck')).to eq(merch_rep.all[204])
    expect(merch_rep.find_by_name('nothing')).to be_nil
  end
end

require './lib/merchant_repository'
require './lib/merchant'

RSpec.describe MerchantRepository do
  before :each do
    @merchant_repository = MerchantRepository.new('./data/merchants.csv')
  end

  it "exists" do

    expect(@merchant_repository).to be_a(MerchantRepository)
  end

  it "returns all known Merchants" do

    expect(@merchant_repository.all).to be_a Array
    expect(@merchant_repository.all.count).to eq(475)
  end

  it "can find_by_id" do

    expect(@merchant_repository.find_by_id(12334105)).to eq(@merchant_repository.all.first)
    expect(@merchant_repository.find_by_id(1233)).to eq(nil)
    expect(@merchant_repository.find_by_id(12334105)).to be_a(Merchant)
  end

  it "can find_by_name" do

    expect(@merchant_repository.find_by_name("Shopin1901")).to eq(@merchant_repository.all.first)
    expect(@merchant_repository.find_by_name("XYZ")).to eq(nil)
    expect(@merchant_repository.find_by_name("Shopin1901")).to be_a(Merchant)
  end

end

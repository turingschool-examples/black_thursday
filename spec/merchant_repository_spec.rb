require './lib/merchant_repository'

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

  xit "can find by id" do

    expect(@merchant_repository.find_by_id).to be_a Array
  end

end

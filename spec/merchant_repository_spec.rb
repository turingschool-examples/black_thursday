require './lib/merchant_repository'

RSpec.describe MerchantRepository do
  before do
    @merchant_repository = MerchantRepository.new('./data/merchants.csv')
  end

  it "exists" do

    expect(@merchant_repository).to be_instance_of MerchantRepository
  end

end

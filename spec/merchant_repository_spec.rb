require './lib/merchant_repository'

RSpec.describe MerchantRepository do
  it "exists" do
    mr = MerchantRepository.new

    expect(mr).to be_a(MerchantRepository)
  end
end

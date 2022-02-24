require "./lib/merchant_repo"
require "./lib/sales_engine"

RSpec.describe MerchantRepository do
  it "can be an instance of merchant repository" do
    mr = se.merchants
    expect(mr).to be_an_instance_of(MerchantRepository)
  end

  it "can return all known merchant instances" do
    expect(mr).to eq([se.merchants])
  end
end

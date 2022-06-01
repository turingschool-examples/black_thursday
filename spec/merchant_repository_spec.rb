require './lib/merchant_repository'

RSpec.describe MerchantRepository do
  before do
    @merchant_repository = MerchantRepository.new('./data/merchants.csv')
  end

  it "exists" do

    expect(@merchant_repository).to be_instance_of MerchantRepository
  end

  it "can return an array of all Merchant instances" do

    expect(@merchant_repository.all).to be_instance_of Array
    expect(@merchant_repository.all.length).to eq(475)
    expect(@merchant_repository.all.first).to be_instance_of Merchant
    expect(@merchant_repository.all.first.id).to eq('12334105')
  end

  it "can find merchant by ID" do

    expect(@merchant_repository.find_by_id('12334105')).to be_instance_of Merchant
  end

  it "can find a merchant by name" do

    expect(@merchant_repository.find_by_name('Shopin1901')).to eq('Shopin1901')
  end
end

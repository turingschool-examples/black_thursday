require 'rspec'
require './lib/merchant_repo'

describe MerchantRepo do
  before(:each) do
    @mr = MerchantRepo.new
  end

  it 'exists' do

    expect(@mr).to be_an_instance_of(MerchantRepo)
  end

  it '.all' do

    expect(MerchantRepo.all).to be_an(Array)
  end

  it ".find_by_id" do
    expect(MerchantRepo.find_by_id(12334105).name).to eq("Shopin1901")
  end
end

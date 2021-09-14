require 'rspec'
require './lib/merchant_repo'

describe MerchantRepo do
  before(:each) do
    @mr = MerchantRepo.new
  end

  xit 'exists' do

    expect(mr.all).to be_an_instance_of(MerchantRepo)
  end

  it '#all' do

    expect(MerchantRepo.all).to be_an(Array)
    expect(MerchantRepo.all).to include(merchant1, merchant2, merchant3, merchant4, merchant5)
  end
end

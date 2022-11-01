require 'rspec'
require './lib/merchant'
require './lib/merchant_repository'

RSpec.describe MerchantRepository do
  it 'can return an array of Merchant instances' do
    mr = MerchantRepository.new

    expect(mr.all).to eq([])
  end


end

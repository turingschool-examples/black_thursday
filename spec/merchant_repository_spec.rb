require 'SimpleCOV'
require 'csv'
require './lib/merchant_repository'

RSpec.describe MerchantRepository do
  it 'exists' do
    mr = MerchantRepository.new

    expect().to be_an_instance_og(MerchantRepository)
  end

  it 'returns an array of all merchant instances' do
    mr = MerchantRepository.new

    expected =

    expect(mr.all).to eq(expected)
  end

  it 'finds merchant by id' do
    mr = MerchantRepository.new

    expect(mr.find_by_id(1175)).to eq()
  end
end

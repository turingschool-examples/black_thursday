require 'simplecov'
SimpleCov.start
require './lib/merchant'
require './lib/merchant_repository'
require 'rspec'

RSpec.describe MerchantRepository do

  before :each do
    @merchant_repository = MerchantRepository.new("./data/merchants.csv")
  end

  it 'exists' do
    expect(@merchant_repository).to be_instance_of(MerchantRepository)
  end

  it 'can return an array of all known Merchant instances' do
    expect(@merchant_repository.all).to be_instance_of(Array)
  end

  it 'can find a merchant by id' do
    expect(@merchant_repository.find_by_id(12334135).name).to eq("GoldenRayPress")
  end

end

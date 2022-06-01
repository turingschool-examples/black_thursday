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

  it 'returns nil when merchant id is not found' do
    expect(@merchant_repository.find_by_id(909090909)).to be nil
  end

  it 'can find a merchant by name' do
    expect(@merchant_repository.find_by_name("GoldenRayPress").id).to eq("12334135")
  end

  it 'is case insensitive when searching by name' do
    expect(@merchant_repository.find_by_name("goldenRAyPreSS").id).to eq("12334135")
  end

  it 'ignores extra spaces before/after when searching by name' do
    expect(@merchant_repository.find_by_name("goldenRAyPreSS    ").id).to eq("12334135")
    expect(@merchant_repository.find_by_name("     goldenRAyPreSS    ").id).to eq("12334135")
  end

  it 'returns all matches with by name fragment' do
    expect(@merchant_repository.find_all_by_name("art")).to be_instance_of(Array)
    expect(@merchant_repository.find_all_by_name("art").count).to eq(35)
  end

  it 'returns highest merchant id' do
    expect(@merchant_repository.max_id).to eq(12337411)
  end

  it 'can create new Merchant instance' do
    @merchant_repository.create("AlexsSaucery")
    @merchant_repository.create("BBQRUS")

    expect(@merchant_repository.find_by_name("AlexsSaucery").id).to eq(12337412)
    expect(@merchant_repository.find_by_name("BBQRUS").id).to eq(12337413)

  end

end

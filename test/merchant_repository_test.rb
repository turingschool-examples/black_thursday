require 'simplecov'
SimpleCov.start
require './lib/helper'

RSpec.describe MerchantRepository do
  let!(:sales_engine) {SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
  })}
  let!(:merchant_repository) {sales_engine.merchants}

  it 'exists' do
    expect(merchant_repository).to be_instance_of(MerchantRepository)
  end

  xit 'can return an array of all known Merchant instances' do
    expect(@merchant_repository.all).to be_instance_of(Array)
  end

  xit 'can find a merchant by id' do
    expect(@merchant_repository.find_by_id(12334135).name).to eq("GoldenRayPress")
  end

  xit 'returns nil when merchant id is not found' do
    expect(@merchant_repository.find_by_id(909090909)).to be nil
  end

  xit 'can find a merchant by name' do
    expect(@merchant_repository.find_by_name("GoldenRayPress").id).to eq(12334135)
  end

  xit 'is case insensitive when searching by name' do
    expect(@merchant_repository.find_by_name("goldenRAyPreSS").id).to eq(12334135)
  end

  xit 'ignores extra spaces before/after when searching by name' do
    expect(@merchant_repository.find_by_name("goldenRAyPreSS    ").id).to eq(12334135)
    expect(@merchant_repository.find_by_name("     goldenRAyPreSS    ").id).to eq(12334135)
  end

  xit 'returns all matches with by name fragment' do
    expect(@merchant_repository.find_all_by_name("art")).to be_instance_of(Array)
    expect(@merchant_repository.find_all_by_name("art").count).to eq(35)
  end

  xit 'returns highest merchant id' do
    expect(@merchant_repository.max_id).to eq(12337411)
  end

  xit 'can create new Merchant instance' do
    @merchant_repository.create("AlexsSaucery")
    @merchant_repository.create("BBQRUS")

    expect(@merchant_repository.find_by_name("AlexsSaucery").id).to eq(12337412)
    expect(@merchant_repository.find_by_name("BBQRUS").id).to eq(12337413)
  end

  xit 'can update name of existing merchant' do
    @merchant_repository.update(12334135,"WowNewName")

    expect(@merchant_repository.find_by_id(12334135).name).to eq("WowNewName")

    expect(@merchant_repository.find_by_name("GoldenRayPress")).to be nil
  end

  xit 'can delete merchant instance by id' do
    @merchant_repository.delete(12334135)

    expect(@merchant_repository.find_by_name("GoldenRayPress")).to be nil
  end

end

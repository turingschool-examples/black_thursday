require 'simplecov'
SimpleCov.start
require './lib/helper'

RSpec.describe MerchantRepository do
  let!(:sales_engine) {SalesEngine.from_csv({:merchants => "./data/merchants.csv"})}
  let!(:merchant_repository) {sales_engine.merchants}
  let!(:time) {Time.now.strftime("%Y-%m-%d %H:%M")}
  let(:new_merchant) {merchant_repository.make_merchant({
    :id => 5,
    :name => "Turing School",
    :created_at => time,
    :updated_at => time
    })}

  it 'exists' do
    expect(merchant_repository).to be_instance_of(MerchantRepository)
  end

  it 'can return an array of all known Merchant instances' do
    expect(merchant_repository.all).to be_instance_of(Array)
  end

  it 'can find a merchant by id' do
    expect(merchant_repository.find_by_id(12334135).name).to eq("GoldenRayPress")
  end

  it 'returns nil when merchant id is not found' do
    expect(merchant_repository.find_by_id(909090909)).to be nil
  end

  it 'can find a merchant by name' do
    expect(merchant_repository.find_by_name("GoldenRayPress").id).to eq(12334135)
  end

  it 'is case insensitive when searching by name' do
    expect(merchant_repository.find_by_name("goldenRAyPreSS").id).to eq(12334135)
  end

  it 'ignores extra spaces before/after when searching by name' do
    expect(merchant_repository.find_by_name("goldenRAyPreSS    ").id).to eq(12334135)
    expect(merchant_repository.find_by_name("     goldenRAyPreSS    ").id).to eq(12334135)
  end

  it 'returns all matches with by name fragment' do
    expect(merchant_repository.find_all_by_name("art")).to be_instance_of(Array)
    expect(merchant_repository.find_all_by_name("art").count).to eq(35)
  end

  it 'returns highest merchant id' do
    expect(merchant_repository.max_id).to eq(12337411)
  end

  it 'can create new item instances' do
    expect(merchant_repository.max_id).to eq(12337411)
    merchant_repository.create({
      :id          => 0,
      :name        => "Pencil",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })

    expect(merchant_repository.max_id).to eq(263567475)
    expect(merchant_repository.find_by_name("Pencil").id).to eq(263567475)
  end

  it 'can update name of existing merchant' do
    merchant_repository.update(12334135,"WowNewName")

    expect(merchant_repository.find_by_id(12334135).name).to eq("WowNewName")

    expect(merchant_repository.find_by_name("GoldenRayPress")).to be nil
  end

  it 'can delete item instances' do
    expect(merchant_repository.all.count).to eq(1367)

    merchant_repository.delete(263438579)

    expect(merchant_repository.all.count).to eq(1366)
  end
end

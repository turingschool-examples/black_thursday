require 'RSpec'
require './lib/sales_engine'
require './lib/item_repository'
require './lib/merchant_repository'

describe MerchantRepository do
  before :each do
    @merchant_repository = MerchantRepository.new("./data/merchants.csv")
  end

  it "exists" do
    expect(@merchant_repository).to be_a MerchantRepository
  end

  it "can return an array of all known merchants" do
    expect(@merchant_repository.all).to be_a Array
    expect(@merchant_repository.all.length).to eq(475)
    expect(@merchant_repository.all.first).to be_a Merchant
    expect(@merchant_repository.all.first.id).to eq(12334105)
    expect(@merchant_repository.all.first.name).to eq("Shopin1901")
  end

  it "can find a merchant by id and return nil if not found" do
    expect(@merchant_repository.find_by_id(12334105)).to be_a Merchant
    expect(@merchant_repository.find_by_id(12334105).name).to eq("Shopin1901")
    expect(@merchant_repository.find_by_id(1)).to eq(nil)
  end

  it "can find merchant by name and return nil if not found " do
    expect(@merchant_repository.find_by_name("Shopin1901")).to be_a Merchant
    expect(@merchant_repository.find_by_name("Shopin1901").id).to eq(12334105)
    expect(@merchant_repository.find_by_name("jake")).to eq(nil)
  end

  it "can find all that will have the same" do
    expect(@merchant_repository.find_all_by_name("MotankiDarena").first.id).to eq(12334146)
    expect(@merchant_repository.find_all_by_name("dojdeo")).to eq([])
  end

  it "can create new merchants" do
    @merchant_repository.create("bees")
    expect(@merchant_repository.all.last).to be_a Merchant
    expect(@merchant_repository.all.last.name).to eq("bees")
    expect(@merchant_repository.all.last.id).to eq(12337412)
  end

  it "can can update merchants instances "do
  @merchant_repository.update(12334105, "test")
  expect(@merchant_repository.find_by_id(12334105).name).to eq("test")
  end

  it "can delete the merchant instace" do
    @merchant_repository.delete(12334105)
    expect(@merchant_repository.all.first.id).to eq(12334112)
  end
end

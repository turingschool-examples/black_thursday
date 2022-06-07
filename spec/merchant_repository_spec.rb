require 'RSpec'
require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'

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

  it "can find merchant by name(case insensitive) and return nil if not found " do
    expect(@merchant_repository.find_by_name("Cand")).to be_a Array
    expect(@merchant_repository.find_by_name("Cand").length).to eq(5)
    expect(@merchant_repository.find_by_name("Cand").first.id).to eq(12334112)
    expect(@merchant_repository.find_by_name("jake")).to eq(nil)
  end

  it "can find all that will have the same name fragment" do
    expect(@merchant_repository.find_all_by_name("MotankiDarena").first.id).to eq(12334146)
    expect(@merchant_repository.find_all_by_name("dojdeo")).to eq([])
  end

  it "can create new merchants" do
    attributes = {:name => "Bees"}
    @merchant_repository.create(attributes)
    expect(@merchant_repository.all.last.name).to eq("Bees")
    expect(@merchant_repository.all.last.id).to eq(12337412)
    expect(@merchant_repository.all.last).to be_a Merchant
  end

  it "can can update merchants instances "do
  @merchant_repository.update(12334105, "test")
  expect(@merchant_repository.find_by_id(12334105).name).to eq("test")
  end

  it "can delete the merchant instance" do
    @merchant_repository.delete(12334105)
    expect(@merchant_repository.all.first.id).to eq(12334112)
  end
end

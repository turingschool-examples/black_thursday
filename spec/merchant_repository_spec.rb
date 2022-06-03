require './lib/merchant_repository'

RSpec.describe MerchantRepository do

  before :each do
    @merchant_repository = MerchantRepository.new('./data/merchants.csv')
  end

  it "exists" do
    expect(@merchant_repository).to be_a(MerchantRepository)
  end

  it "has an array of Merchant instances (all)" do
    expect(@merchant_repository.all).to be_a(Array)
    expect(@merchant_repository.all.length).to eq(475)
    expect(@merchant_repository.all.first).to be_a(Merchant)
    expect(@merchant_repository.all.first.id).to eq(12334105)
  end

  it "can find_by_id" do
    expect(@merchant_repository.find_by_id(999)).to be_nil
    expect(@merchant_repository.find_by_id(12334105)).to be_a(Merchant)
    expect(@merchant_repository.find_by_id(12334105).id).to eq(12334105)
    expect(@merchant_repository.find_by_id(12334105).name).to eq("Shopin1901")
  end

  it "can find_by_name" do
    expect(@merchant_repository.find_by_name("Nonexistent")).to be_nil
    expect(@merchant_repository.find_by_name("Shopin1901")).to be_a(Merchant)
    expect(@merchant_repository.find_by_name("Shopin1901").id).to eq(12334105)
    expect(@merchant_repository.find_by_name("Shopin1901").name).to eq("Shopin1901")
  end

  it "can find_all_by_name" do
    expect(@merchant_repository.find_all_by_name("snortiblortiblarf")).to eq([])
    expect(@merchant_repository.find_all_by_name("craft")).to be_a(Array)
    expect(@merchant_repository.find_all_by_name("craft").length).to eq(11)
    expect(@merchant_repository.find_all_by_name("cRaFT").length).to eq(11)
  end

  it "can create new Merchant instance" do
    expect(@merchant_repository.find_by_id(12337412)).to be_nil
    @merchant_repository.create({name: "Something Store"})
    expect(@merchant_repository.find_by_id(12337412)).to be_a(Merchant)
    expect(@merchant_repository.find_by_id(12337412).name).to eq("Something Store")
  end

  it "can update instances" do
    @merchant_repository.create({name: "Something Store"})
    expect(@merchant_repository.find_by_id(12337412).name).to eq("Something Store")
    @merchant_repository.update(12337412, {name: "Something Else Store"})
    expect(@merchant_repository.find_by_id(12337412).name).to eq("Something Else Store")
    expect(@merchant_repository.update(999, "Nonexistent Store")).to be_nil
  end

  it "can delete instances" do
    @merchant_repository.create({name: "Something Store"})
    expect(@merchant_repository.find_by_id(12337412)).to be_a(Merchant)
    @merchant_repository.delete(12337412)
    expect(@merchant_repository.find_by_id(12337412)).to be_nil
    expect(@merchant_repository.find_by_name("Something Store")).to be_nil
  end

end

require './lib/merchant_repository'
require './lib/merchant'

RSpec.describe MerchantRepository do
  before :each do
    @merchant_repository = MerchantRepository.new('./data/merchants.csv')
  end

  it "exists" do

    expect(@merchant_repository).to be_a(MerchantRepository)
  end

  it "returns all known Merchants" do

    expect(@merchant_repository.all).to be_a Array
    expect(@merchant_repository.all.count).to eq(475)
  end

  it "can find_by_id" do

    expect(@merchant_repository.find_by_id(12334105)).to eq(@merchant_repository.all.first)
    expect(@merchant_repository.find_by_id(1233)).to eq(nil)
    expect(@merchant_repository.find_by_id(12334105)).to be_a(Merchant)
  end

  it "can find_by_name" do

    expect(@merchant_repository.find_by_name("Shopin1901")).to eq(@merchant_repository.all.first)
    expect(@merchant_repository.find_by_name("XYZ")).to eq(nil)
    expect(@merchant_repository.find_by_name("Shopin1901")).to be_a(Merchant)
  end

  it 'can find_all_by_name(name)' do
    test = @merchant_repository.find_all_by_name("handmade")

    expect(@merchant_repository.find_all_by_name("handmade").count).to eq(6)
    expect(@merchant_repository.find_all_by_name("handmade")).to be_a(Array)
    expect(test.map(&:name).include?("SLHandmades")).to eq true
    expect(test.map(&:id).include?(12334303)).to eq true
  end

  it 'can create_attributes' do
    attributes = {
      name: "BryceGems"
    }

    expect(@merchant_repository.create(attributes).last.id).to eq(12337412)
    expect(@merchant_repository.all.last).to be_a(Merchant)
    expect(@merchant_repository.all.count).to eq(476)
  end

  it "can update(id, attributes) an merchant instance" do
    attributes = {
      name: "BryceGems"
    }

    @merchant_repository.update(12334105, attributes)

    expect(@merchant_repository.find_by_id(12334105).name).to eq("BryceGems")
    expect(@merchant_repository.find_by_name("Shopin1901")).to eq(nil)
  end

  it "can delete a merchant instance" do

    expect(@merchant_repository.find_by_name("Shopin1901")).to be_a(Merchant)
    @merchant_repository.delete(12334105)
    expect(@merchant_repository.find_by_name("Shopin1901")).to eq(nil)
  end

  

end

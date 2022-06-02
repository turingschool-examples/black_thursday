require './lib/merchant_repository'

RSpec.describe MerchantRepository do
  before do
    @merchant_repository = MerchantRepository.new('./data/merchants.csv')
  end

  it "exists" do

    expect(@merchant_repository).to be_instance_of MerchantRepository
  end

  it "can return an array of all Merchant instances" do

    expect(@merchant_repository.all).to be_instance_of Array
    expect(@merchant_repository.all.length).to eq(475)
    expect(@merchant_repository.all.first).to be_instance_of Merchant
    expect(@merchant_repository.all.first.id).to eq(12334105)
  end

  it "can find merchant by ID" do

    expect(@merchant_repository.find_by_id(12334105)).to be_instance_of Merchant
  end

  it "can find a merchant by name" do

    expect(@merchant_repository.find_by_name('Shopin1901')).to be_instance_of Merchant
  end

  it "can find all merchants by name" do

    expect(@merchant_repository.find_all_by_name('YouWontFindMe')).to eq([])
    expect(@merchant_repository.find_all_by_name('Shopin1901')).to be_instance_of Array
    expect(@merchant_repository.find_all_by_name('Shopin1901').first).to be_instance_of Merchant
  end

  it "can create new merchant IDs" do

    expect(@merchant_repository.new_id).to be_a Integer
  end

  it "can create new merchants" do

    expect(@merchant_repository.create('Ducky')).to be_a Array
    expect(@merchant_repository.all.last.name).to eq('Ducky')
  end

  it "update the Item instance with the corresponding id with the provided attributes" do

    expect(@merchant_repository.update(12334105))

  end
end

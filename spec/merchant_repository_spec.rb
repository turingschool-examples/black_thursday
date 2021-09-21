require './lib/merchant_repository'
require './lib/merchant'

RSpec.describe MerchantRepository do
  it "exists" do
    merchants_path = './data/merchants.csv'
    merchant_repository = MerchantRepository.new(merchants_path)
    expect(merchant_repository).to be_an_instance_of(MerchantRepository)
  end

  it 'can return an array of all known merchants' do
    merchants_path = './data/merchants.csv'
    merchant_repository = MerchantRepository.new(merchants_path)
    expect(merchant_repository.all[0]).to be_an_instance_of(Merchant)
    expect(merchant_repository.all.count).to eq 475
  end

  it 'can find merchant by id' do
    merchants_path = './data/merchants.csv'
    merchant_repository = MerchantRepository.new(merchants_path)
    example_merchant = merchant_repository.all[25]
    expect(merchant_repository.find_by_id(example_merchant.id)).to eq example_merchant
    expect(merchant_repository.find_by_id(999999)).to eq nil
  end

  it 'can find merchants by name' do
    merchants_path = './data/merchants.csv'
    merchant_repository = MerchantRepository.new(merchants_path)
    example_merchant = merchant_repository.all[25]
    expect(merchant_repository.find_by_name(example_merchant.name)).to eq example_merchant
    expect(merchant_repository.find_by_name("woody woodpecker")).to eq nil
  end

  it 'can create a merchant with given attributes' do
    merchants_path = './data/merchants.csv'
    merchant_repository = MerchantRepository.new(merchants_path)
    expect(merchant_repository.find_by_id(12337412)).to eq(nil)
    merchant_repository.create({:id => 12337412, :name => "Lil_Shop"})
    expect(merchant_repository.find_by_id(12337412)).not_to eq(nil)
    expect(merchant_repository.all.last.id).to eq(12337412)
  end

 #  it 'can update merchant attributes using ID' do
 #    merchants_path = './data/merchants.csv'
 #    merchant_repository = MerchantRepository.new(merchants_path)
 #    merchant_repository.create(:name => "Shopkeep0", :id => 12337412)
 #    merchant_repository.update(12337412, "ThisTestWillPass")
 #    expect((merchant_repository.find_by_id(12337412)).name).to eq "ThisTestWillPass"
 #  end
 #
 #  it 'can delete a merchant by ID' do
 #    merchants_path = './data/merchants.csv'
 #    merchant_repository = MerchantRepository.new(merchants_path)
 #    merchant_repository.create(:name => "Shopkeep0", :id => 12337412)
 #    expect(merchant_repository.all.count).to eq 476
 #    merchant_repository.delete(12337412)
 #    expect(merchant_repository.all.count).to eq 475
 # end
end

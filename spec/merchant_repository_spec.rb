require './lib/merchant.rb'
require './lib/merchant_repository.rb'

RSpec.describe MerchantRepository do
  it 'exists' do
    merchant_repo = MerchantRepository.new('./data/merchants.csv')
    expect(merchant_repo).to be_a(MerchantRepository)
  end

  it 'returns an array of all known Merchant instances' do
    merchant_repo = MerchantRepository.new('./data/merchants.csv')
    expect(merchant_repo.all.count).to eq(475)
  end

  it 'can find merchant by ID' do
    merchant_repo = MerchantRepository.new('./data/merchants.csv')
    expect(merchant_repo.find_by_id(12334105)).to be_a(Merchant)
    expect(merchant_repo.find_by_id(12948129048)).to eq(nil)
  end

  it 'can find merchant by name' do
    merchant_repo = MerchantRepository.new('./data/merchants.csv')
    expect(merchant_repo.find_by_name('Shopin1901')).to be_instance_of(Merchant)
    expect(merchant_repo.find_by_name('sHoPiN1901')).to be_instance_of(Merchant)
    expect(merchant_repo.find_by_name('InvalidName')).to eq(nil)
  end

  it 'can find all merchants by name fragment' do
    merchant_repo = MerchantRepository.new('./data/merchants.csv')
    merchant_repo.find_all_by_name("mini").each do |merchant|
        expect(merchant.name.downcase.include?("mini")).to eq(true)
        expect(merchant).to be_instance_of(Merchant)
      end
    expect(merchant_repo.find_all_by_name('mini')).to be_instance_of(Array)

    merchant_repo.find_all_by_name("MiNi").each do |merchant|
        expect(merchant.name.downcase.include?("mini")).to eq(true)
        expect(merchant).to be_instance_of(Merchant)
      end

    expect(merchant_repo.find_all_by_name('MiNi')).to be_instance_of(Array)
    expect(merchant_repo.find_all_by_name('inG')).to be_instance_of(Array)
    expect(merchant_repo.find_all_by_name('sHoPiN')).to be_instance_of(Array)
    expect(merchant_repo.find_all_by_name('sHoPiN1901')).to be_instance_of(Array)

    merchant_repo.find_all_by_name("InvalidName").each do |merchant|
        expect(merchant.name.downcase.include?("invalidname")).to eq(false)
        expect(merchant).to eq(nil)
      end
    expect(merchant_repo.find_all_by_name('InvalidName')).to eq([])
  end

  it "can create a new merchant instance" do
    merchant_repo = MerchantRepository.new('./data/merchants.csv')
    new_merchant = merchant_repo.create("Turing School of Software and Design")
    expect(new_merchant.name).to eq("Turing School of Software and Design")
    expect(merchant_repo.find_by_id(12337412)).to be_a(Merchant)
  end

  it "can update a merchant object" do
    merchant_repo = MerchantRepository.new('./data/merchants.csv')
    expect(merchant_repo.find_by_id(12334105).name).to eq("Shopin1901")
    merchant_repo.update(12334105, "Shopin2022")
    expect(merchant_repo.find_by_id(12334105).name).to eq("Shopin2022")
    expect(merchant_repo.find_by_name("Shopin1901")).to eq(nil)
  end

  it 'can delete a merchant object' do
    merchant_repo = MerchantRepository.new('./data/merchants.csv')
    expect(merchant_repo.find_by_id(12334105)).to be_a(Merchant)
    merchant_repo.delete(12334105)
    expect(merchant_repo.find_by_id(12334105)).to eq(nil)
  end

end

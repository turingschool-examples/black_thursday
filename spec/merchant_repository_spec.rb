require './lib/merchant_repository'
require './lib/merchant'

RSpec.describe MerchantRepository do
  let(:merchant_repository) {MerchantRepository.new}
  let(:merchant) {Merchant.new({:id => 1, :name => "Turing School"})}
  let(:merchant1) {Merchant.new({:id => 2, :name => "Turing Coffee"})}

  it 'is an instance of a #merchant_repository' do
    expect(merchant_repository).to be_a(MerchantRepository)
  end

  it 'has a method to return all merchant instances' do
    expect(merchant_repository.all).to eq([])

    merchant_repository.all << merchant
    expect(merchant_repository.all).to eq([merchant])

    merchant_repository.all << merchant1
    expect(merchant_repository.all).to eq([merchant, merchant1])
  end

  it 'has a method to find a merchant by its ID' do
    merchant_repository.all << merchant
    expect(merchant_repository.find_by_id(1)).to eq(merchant)
  end

  it 'has a method to find a merchant by its name' do
    merchant_repository.all << merchant
    expect(merchant_repository.find_by_name("Turing School")).to eq(merchant)
    expect(merchant_repository.find_by_name("tuRing schOol")).to eq(merchant)
  end

  it 'has a method to find all merchants which have part of a name in common' do
    merchant_repository.all << merchant
    merchant_repository.all << merchant1
    expect(merchant_repository.find_all_by_name("Turing")).to eq([merchant, merchant1])
    expect(merchant_repository.find_all_by_name("school")).to eq([merchant])
    expect(merchant_repository.find_all_by_name("coFFee")).to eq([merchant1])
    expect(merchant_repository.find_all_by_name("muffin")).to eq([])
  end
end
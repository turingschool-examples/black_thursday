require './lib/merchantrepository'
require './lib/merchant'

RSpec.describe Merchant_Repository do
  let(:merchant_repository) {Merchant_Repository.new}
  let(:merchant) {Merchant.new({:id => 1, :name => "Turing School"})}
  let(:merchant1) {Merchant.new({:id => 2, :name => "Turing Coffee"})}

  it 'is an instance of a #merchant_repository' do
    expect(merchant_repository).to be_a(Merchant_Repository)
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

  it 'has a method to create a new instance of a merchant with the supplied information' do
    merchant_repository.create("Seattle Muffins")
    expect(merchant_repository.all[0].id).to eq(1)
    expect(merchant_repository.all[0].name).to eq("Seattle Muffins")

    merchant_repository.create("Denver Biscuits")
    expect(merchant_repository.all[1].id).to eq(2)
    expect(merchant_repository.all[1].name).to eq("Denver Biscuits")
  end

  xit 'has a method to update the NAME only of a merchant' do
    merchant_repository.create("Denver Biscuits")
    merchant_repository.create("Seattle Muffins")
    
    merchant_repository.update(2, "Seattle Super Muffins")
   
    expect(merchant_repository.find_by_name("Seattle Super Muffins")).to eq(merchant_repository.find_by_id(2))
    expect(merchant_repository.find_all_by_name("super")).to eq([merchant_repository.merchants[1]])
  end

  it 'has a method to delete a merchant from the list using its ID' do
    merchant_repository.create("Denver Biscuits")
    merchant_repository.create("Seattle Muffins")
    
    merchant_repository.delete(2)
    
    expect(merchant_repository.all[0]).to eq(merchant_repository.find_by_id(2))
    expect(merchant_repository.find_by_id(1)).to eq(nil)
    expect(merchant_repository.find_by_name("Denver Biscuits")).to eq(nil)
  end
end
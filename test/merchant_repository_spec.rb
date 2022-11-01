require './lib/merchant'
require './lib/merchant_repository'

RSpec.describe MerchantRepository do
  it 'exists' do
    merch_repo = MerchantRepository.new

    expect(merch_repo).to be_a(MerchantRepository)
  end

  it 'stores merchants, empty by default' do
    merch_repo = MerchantRepository.new

    expect(merch_repo.merchants).to eq([])
  end

  it 'creates new Merchants' do 
    merch_repo = MerchantRepository.new
    merch_repo.create({:id => 5, :name => "Turing School"})

    expect(merch_repo.merchants[0]).to be_a(Merchant)
  end

  it 'lists all Merchants' do
    merch_repo = MerchantRepository.new
    merch_repo.create({:id => 5, :name => "Turing School"})
    merch_repo.create({:id => 6, :name => "Another School"})
    merch_repo.create({:id => 7, :name => "The Other School"})

    
    expect(merch_repo.all).to be_a(Array)
    expect(merch_repo.all[0]).to be_a(Merchant)
    expect(merch_repo.all[1]).to be_a(Merchant)
    expect(merch_repo.all[2]).to be_a(Merchant)
    expect(merch_repo.all.count).to eq(3)
  end

  it 'finds Merchants by id' do
    merch_repo = MerchantRepository.new
    merch_repo.create({:id => 5, :name => "Turing School"})
    merch_repo.create({:id => 6, :name => "Another School"})
    merch_repo.create({:id => 7, :name => "The Other School"})
  
    expect(merch_repo.find_by_id(5)).to be_a(Merchant)
    expect(merch_repo.find_by_id(8)).to be(NIL)
  end
end
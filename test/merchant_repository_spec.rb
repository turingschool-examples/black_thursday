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

  it 'creates new Merchants, id + 1' do 
    merch_repo = MerchantRepository.new
    merchant1 = merch_repo.create({:id => 1, :name => "Turing School"})
    merchant2 = merch_repo.create({:id => 4, :name => "Another School"})
    merchant3 = merch_repo.create({:name => "The Other School"})
    
    expect(merchant1).to be_a(Merchant)
    expect(merchant1.id).to eq(1)
    expect(merchant2.id).to eq(2)
    expect(merchant3.id).to eq(3)
  end

  it 'lists all Merchants' do
    merch_repo = MerchantRepository.new
    merchant1 = merch_repo.create({:id => 5, :name => "Turing School"})
    merchant2 = merch_repo.create({:id => 6, :name => "Another School"})
    merchant3 = merch_repo.create({:id => 7, :name => "The Other School"})
 

    expect(merch_repo.all).to eq([merchant1, merchant2, merchant3])
  end

  it 'finds Merchants by id' do
    merch_repo = MerchantRepository.new
    merchant1 = merch_repo.create({:id => 5, :name => "Turing School"})
    merchant2 = merch_repo.create({:id => 4, :name => "Another School"})
    merchant3 = merch_repo.create({:id => 2, :name => "The Other School"})
  

    expect(merch_repo.find_by_id(5)).to eq(merchant1)
    expect(merch_repo.find_by_id(8)).to be(NIL)
  end


  it 'finds Merchants by name' do 
    merch_repo = MerchantRepository.new
    merchant1 = merch_repo.create({:id => 5, :name => "Turing School"})
    merchant2 = merch_repo.create({:id => 6, :name => "Another School"})
    merchant3 = merch_repo.create({:id => 7, :name => "The Other School"})

    expect(merch_repo.find_by_name("turing school")).to eq(merchant1)
    expect(merch_repo.find_by_name("Bobby's World")).to be(NIL)
   end

  it 'finds all by name' do
    merch_repo = MerchantRepository.new
    merchant1 = merch_repo.create({:id => 5, :name => "Turing School"})
    merchant2 = merch_repo.create({:id => 6, :name => "Another School"})
    merchant3 = merch_repo.create({:id => 7, :name => "The Other School"})

    expect(merch_repo.find_all_by_name("school")).to eq([merchant1, merchant2, merchant3])

    expect(merch_repo.find_all_by_name("Bobby's World")).to eq([])
  end

  it 'deletes Merchants by id' do
    merch_repo = MerchantRepository.new

    merchant1 = merch_repo.create({:id => 5, :name => "Turing School"})
    merchant2 = merch_repo.create({:id => 6, :name => "Another School"})
    merchant3 = merch_repo.create({:id => 7, :name => "The Other School"})


    expect(merch_repo.all).to eq([merchant1, merchant2, merchant3])

    merch_repo.delete(6)

    expect(merch_repo.all).to eq([merchant1, merchant3])
  end

  it 'can update merchant name' do
    merch_repo = MerchantRepository.new
    merchant1 = merch_repo.create({:id => 5, :name => "Turing School"})

    expect(merchant1.name).to eq("Turing School")
   
    merch_repo.update(5, "Different School")
 
    expect(merchant1.name).to eq("Different School")
  end
end



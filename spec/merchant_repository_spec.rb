require 'rspec'
require './lib/merchant'
require './lib/merchant_repository'

describe MerchantRepository do
  let!(:merchant_repository) {MerchantRepository.new}
  it 'exists' do
    expect(merchant_repository).to be_a MerchantRepository
  end

  it 'returns an array of known merchant instances' do
    merchant_1 = Merchant.new({:id => 6, :name => "Walmart"})
    merchant_2 = Merchant.new({:id => 7, :name => "Target"})

    expect(merchant_repository.all).to eq([])

    merchant_repository.add_merchant_to_repo(merchant_1)

    expect(merchant_repository.all).to eq([merchant_1])

    merchant_repository.add_merchant_to_repo(merchant_2)

    expect(merchant_repository.all).to eq([merchant_1, merchant_2])
  end

  describe '#find_by_id' do
    it 'returns either nil or an instance of merchant with the matching ID' do
      merchant_1 = Merchant.new({:id => 6, :name => "Walmart"})
      merchant_2 = Merchant.new({:id => 7, :name => "Target"})
      merchant_repository.add_merchant_to_repo(merchant_1)
      merchant_repository.add_merchant_to_repo(merchant_2)

      expect(merchant_repository.find_by_id(10)).to eq(nil)
      expect(merchant_repository.find_by_id(6)).to eq(merchant_1)
      expect(merchant_repository.find_by_id(7)).to eq(merchant_2)
    end
  end

  describe '#find_by_name' do
    it 'can find merchant by name' do 
      merchant_1 = Merchant.new({:id => 6, :name => "Walmart"})
      merchant_2 = Merchant.new({:id => 7, :name => "Target"})
      merchant_repository.add_merchant_to_repo(merchant_1)
      merchant_repository.add_merchant_to_repo(merchant_2)
  
      expect(merchant_repository.find_by_name("Safeway")).to eq(nil)
      expect(merchant_repository.find_by_name("Walmart")).to eq(merchant_1)
      expect(merchant_repository.find_by_name("WaLmArT")).to eq(merchant_1)
    end
  end
  
  describe '#find_all_by_name' do 
    it 'can find all merchants that share part of their name' do 
      merchant_1 = Merchant.new({:id => 6, :name => "Amazon Fresh"})
      merchant_2 = Merchant.new({:id => 7, :name => "Amazon Prime"})
      merchant_3 = Merchant.new({:id => 7, :name => "Walmart"})
      merchant_repository.add_merchant_to_repo(merchant_1)
      merchant_repository.add_merchant_to_repo(merchant_2)
      merchant_repository.add_merchant_to_repo(merchant_3)
  
      expect(merchant_repository.find_all_by_name("Amazon")).to eq([merchant_1, merchant_2])
      expect(merchant_repository.find_all_by_name("AmAzOn")).to eq([merchant_1, merchant_2])
      expect(merchant_repository.find_all_by_name("Safeway")).to eq([])
    end
  end

  describe '#create' do 
    it 'can create a new merchant instance' do 
      merchant = merchant_repository.create("Whole Foods")

      expect(merchant.id).to eq(1)

      merchant_1 = Merchant.new({:id => 6, :name => "Amazon Fresh"})

      merchant_repository.add_merchant_to_repo(merchant_1)

      merchant_2 = merchant_repository.create("Walmart")
      merchant_3 = merchant_repository.create("Target")
      
      expect(merchant_2).to be_a Merchant
      expect(merchant_2.name).to eq("Walmart")
      expect(merchant_2.id).to eq(7)
      expect(merchant_1.id).to eq(6)
      expect(merchant_3.id).to eq(8)
      expect(merchant_repository.all).to eq([merchant, merchant_1, merchant_2, merchant_3,])
    end
  end

  describe '#update' do 
    it 'can update merchants name' do 
      merchant_1 = merchant_repository.create("Safeway")
      merchant_2 = merchant_repository.create("Walmart")
      merchant_3 = merchant_repository.create("Target")

      merchant_repository.update(1, "Costco")
      merchant_repository.update(2, "LaGree's")
      merchant_repository.update(3, "Natural Grocers")
      
      expect(merchant_1.name).to eq("Costco")
      expect(merchant_2.name).to eq("LaGree's")
      expect(merchant_3.name).to eq("Natural Grocers")
    end
  end

  describe '#delete' do 
    it 'deletes the merchant instance with the corosponding id' do 
      merchant_1 = merchant_repository.create("Safeway")
      merchant_2 = merchant_repository.create("Walmart")
      merchant_3 = merchant_repository.create("Target")

      merchant_repository.delete(1)

      expect(merchant_repository.all).to eq([merchant_2, merchant_3])

      merchant_repository.delete(2)

      expect(merchant_repository.all).to eq([merchant_3])

      merchant_repository.delete(4)

      expect(merchant_repository.all).to eq([merchant_3])
    end
  end
end

require './test/spec_helper'

RSpec.describe MerchantRepository do
  describe '#initialize' do
    it 'exists' do
      merchant_1 = Merchant.new({:id => 1,
                                 :name => "Nike"})
      merchant_2 = Merchant.new({:id => 2,
                                 :name => "Addidas"})
      merchants = [merchant_1, merchant_2]
      merchant_repository = MerchantRepository.new(merchants)

      expect(merchant_repository).to be_a(MerchantRepository)
    end
  end

  describe '#all' do
    it 'returns an array of all known merchants' do
      merchant_1 = Merchant.new({:id => 1,
                                 :name => "Nike"})
      merchant_2 = Merchant.new({:id => 2,
                                 :name => "Addidas"})
      merchants = [merchant_1, merchant_2]
      merchant_repository = MerchantRepository.new(merchants)

      expect(merchant_repository.all).to eq([merchant_1, merchant_2])
    end
  end

  describe '#find_by_id' do
    it 'finds and returns a merchant object by id' do
      merchant_1 = Merchant.new({:id => 1,
                                 :name => "Nike"})
      merchant_2 = Merchant.new({:id => 2,
                                 :name => "Addidas"})
      merchants = [merchant_1, merchant_2]
      merchant_repository = MerchantRepository.new(merchants)

      expect(merchant_repository.find_by_id(1)).to eq(merchant_1)
    end
  end

  describe '#find_by_name' do
    it 'finds a merchant object with a case insensitve name search' do
      merchant_1 = Merchant.new({:id => 1,
                                 :name => "Nike"})
      merchant_2 = Merchant.new({:id => 2,
                                 :name => "Addidas"})
      merchants = [merchant_1, merchant_2]
      merchant_repository = MerchantRepository.new(merchants)

      expect(merchant_repository.find_by_name("NIKE")).to eq(merchant_1)
    end
  end

  describe '#find_all_by_name' do
    it 'returns an array of all merchants with a specific case insensitve name' do
      merchant_1 = Merchant.new({:id => 1,
                                 :name => "Nike"})
      merchant_2 = Merchant.new({:id => 2,
                                 :name => "Addidas"})
      merchant_3 = Merchant.new({:id => 3,
                                 :name => "Addidas"})
      merchants = [merchant_1, merchant_2, merchant_3]
      merchant_repository = MerchantRepository.new(merchants)

      expect(merchant_repository.find_all_by_name("AdDiDas")).to eq([merchant_2, merchant_3])
    end
  end

  describe '#create' do
    it 'creates a new merchant with attributes' do
      merchant_1 = Merchant.new({:id => 1,
                                 :name => "Nike"})
      merchant_2 = Merchant.new({:id => 2,
                                 :name => "Addidas"})
      merchants = [merchant_1, merchant_2]
      merchant_repository = MerchantRepository.new(merchants)
      merchant_3 = merchant_repository.create({:name => "Puma"})

      expect(merchant_3.name).to eq("Puma")
      expect(merchant_3.id).to eq(3)
      expect(merchant_repository.find_by_id(3)).to eq(merchant_3)
    end
  end

  describe '#update' do
    it 'updates the name of a merchant with the given id' do
      merchant_1 = Merchant.new({:id => 1,
                                 :name => "Nike"})
      merchant_2 = Merchant.new({:id => 2,
                                 :name => "Addidas"})
      merchants = [merchant_1, merchant_2]
      merchant_repository = MerchantRepository.new(merchants)
      merchant_repository.update({:id => 1, :name => "Facebook"})

      expect(merchant_repository.find_by_id(1).name).to eq("Facebook")
    end
  end

  describe '#delete' do
    it 'deletes a specific merchant from the repository' do
      merchant_1 = Merchant.new({:id => 1,
                                 :name => "Nike"})
      merchant_2 = Merchant.new({:id => 2,
                                 :name => "Addidas"})
      merchants = [merchant_1, merchant_2]
      merchant_repository = MerchantRepository.new(merchants)
      merchant_repository.delete(1)

      expect(merchant_repository.all.include?(merchant_1)).to eq(false)
    end
  end
end

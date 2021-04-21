require 'CSV'
require 'sales_engine'
require 'merchant'

RSpec.describe MerchantRepo do
  describe 'instantiation' do
    it'::new' do
      mock_engine = double('MerchantRepo')
      merchant_repo = MerchantRepo.new('./fixtures/mock_items.csv', mock_engine)

      expect(merchant_repo).to be_an_instance_of(MerchantRepo)
    end
  end

  describe '#methods' do
    it '#all' do
      mock_engine = double('MerchantRepo')
      merchant_repo = MerchantRepo.new('./fixtures/mock_items.csv', mock_engine)

      expect(merchant_repo.all).to be_an_instance_of(Array)
    end

    it '#find merchant by ID' do
      mock_engine = double('MerchantRepo')
      merchant_repo = MerchantRepo.new('./fixtures/mock_items.csv', mock_engine)
      collection = merchant_repo.merchants
      merchant = merchant_repo.create({:id => 5,
                                     :name => "Turing School",
                                     :created_at => Time.now,
                                     :updated_at => Time.now
                                     })


      expect(merchant_repo.find_by_id(merchant.id, collection)).to eq(merchant)
      expect(merchant_repo.find_by_id(999999999, collection)).to eq(nil)
    end

    it '#find merchant by name' do
      mock_engine = double('MerchantRepo')
      merchant_repo = MerchantRepo.new('./fixtures/mock_items.csv', mock_engine)
      collection = merchant_repo.merchants
      merchant = merchant_repo.create({:id => 5,
                                     :name => "Turing School",
                                     :created_at => Time.now,
                                     :updated_at => Time.now
                                    })

      expect(merchant_repo.find_by_name("Turing School", collection)).to eq(merchant)
      expect(merchant_repo.find_by_name("Hogwarts School", collection)).to eq(nil)
    end

    it '#find all merchants by name' do
      mock_engine = double('MerchantRepo')
      merchant_repo = MerchantRepo.new('./fixtures/mock_items.csv', mock_engine)
      collection = merchant_repo.merchants
      merchant = merchant_repo.create({:id => 5,
                                       :name => "Turing School",
                                       :created_at => Time.now,
                                       :updated_at => Time.now
                                       })

      expect(merchant_repo.find_all_by_name("Turing Scho", collection)).to eq([merchant])
      expect(merchant_repo.find_all_by_name("Hogwar", collection)).to eq([])
    end

    it '#create merchant' do
      mock_engine = double('MerchantRepo')
      merchant_repo = MerchantRepo.new('./fixtures/mock_items.csv', mock_engine)
      merchant = merchant_repo.create({:id => 5,
                                       :name => "Turing School",
                                       :created_at => Time.now,
                                       :updated_at => Time.now
                                       })

      expect(merchant).to be_an_instance_of(Merchant)
    end

    it '#updates attributes' do
      mock_engine = double('MerchantRepo')
      merchant_repo = MerchantRepo.new('./fixtures/mock_items.csv', mock_engine)
      merchant = merchant_repo.create({:id => 5,
                                       :name => "Turing School",
                                       :created_at => Time.now,
                                       :updated_at => Time.now
                                       })

      updated_attributes = {:name => "School of Life"}

      merchant_repo.update(merchant.id, updated_attributes)
      expect(merchant.name).to eq("School of Life")
    end

    it '#delete merchant' do
      mock_engine = double('MerchantRepo')
      merchant_repo = MerchantRepo.new('./fixtures/mock_items.csv', mock_engine)
      collection = merchant_repo.merchants
      merchant = merchant_repo.create({:id => 5,
                                       :name => "Turing School",
                                       :created_at => Time.now,
                                       :updated_at => Time.now
                                       })

      expect(merchant_repo.find_by_id(merchant.id, collection)).to eq(merchant)
      merchant_repo.delete(merchant.id)
      expect(merchant_repo.find_by_id(merchant.id, collection)).to eq(nil)
    end
  end
end

require 'CSV'
require 'sales_engine'
require 'merchant'

RSpec.describe MerchantRepo do
  before(:each) do
    @sales_engine = SalesEngine.from_csv({:items => './data/items.csv',
                                          :merchants => './data/merchants.csv',
                                          :invoices => './data/invoices.csv',
                                          :invoice_items => './data/invoice_items.csv',
                                          :transactions  => './data/transactions.csv',
                                          :customers => './data/customers.csv'
                                        })
  end
  
  describe 'instantiation' do
    it '::new' do
      merchant_repo = @sales_engine.merchants

      expect(merchant_repo).to be_an_instance_of(MerchantRepo)
    end
  end

  describe '#methods' do
    it '#all' do
      merchant_repo = @sales_engine.merchants

      expect(merchant_repo.all).to be_an_instance_of(Array)
    end

    it '#find merchant by ID' do
      merchant_repo = @sales_engine.merchants
      merchant = merchant_repo.create({:id => 5,
                                       :name => "Turing School"})
      

      expect(merchant_repo.find_by_id(merchant.id)).to eq(merchant)
      expect(merchant_repo.find_by_id(999999999)).to eq(nil)
    end

    it '#find merchant by name' do
      merchant_repo = @sales_engine.merchants
      merchant = merchant_repo.create({:id => 5,
                                       :name => "Turing School"})

      expect(merchant_repo.find_by_name("Turing School")).to eq(merchant)
      expect(merchant_repo.find_by_name("Hogwarts School")).to eq(nil)
    end

    it '#find all merchants by name' do
      merchant_repo = @sales_engine.merchants
      merchant = merchant_repo.create({:id => 5,
                                       :name => "Turing School"})

      expect(merchant_repo.find_by_name("Turing School")).to eq(merchant)
      expect(merchant_repo.find_all_by_name("Hogwar")).to eq([])
    end

    it '#create merchant' do
      merchant_repo = @sales_engine.merchants
      merchant_info = {:id => 5, 
                       :name => "Turing School"}

      expect(merchant_repo.create(merchant_info)).to be_an_instance_of(Merchant)
    end

    it '#updates attributes' do
      merchant_repo = @sales_engine.merchants
      merchant = merchant_repo.create({:id => 5,
                                     :name => "Turing School"})

      updated_attributes = {:name => "School of Life"}

      merchant_repo.update(merchant.id, updated_attributes)
      expect(merchant.name).to eq("School of Life")
    end

    it '#delete merchant' do
      merchant_repo = @sales_engine.merchants
      merchant = merchant_repo.create({:id => 5,
                                       :name => "Turing School"})
      
      expect(merchant_repo.find_by_id(merchant.id)).to eq(merchant)
      merchant_repo.delete(merchant.id)
      expect(merchant_repo.find_by_id(merchant.id)).to eq(nil)
    end
  end
end

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
    xit'::new' do
      merchant_repo = @sales_engine.merchants

      expect(merchant_repo).to be_an_instance_of(MerchantRepo)
    end
  end

  describe '#methods' do
    xit'#all' do
      merchant_repo = @sales_engine.merchants

      expect(merchant_repo.all).to be_an_instance_of(Array)
    end

    xit'#find merchant by ID' do
    merchant_repo = @sales_engine.merchants
    collection = merchant_repo.merchants
    merchant = merchant_repo.create({:id => 5,
                                     :name => "Turing School"})


    expect(merchant_repo.find_by_id(merchant.id, collection)).to eq(merchant)
    expect(merchant_repo.find_by_id(999999999, collection)).to eq(nil)
  end

  it'#find merchant by name' do
    merchant_repo = @sales_engine.merchants
    collection = merchant_repo.merchants
    merchant = merchant_repo.create({:id => 5,
                                     :name => "Turing School"})

    expect(merchant_repo.find_by_name("Turing School", collection)).to eq(merchant)
    expect(merchant_repo.find_by_name("Hogwarts School", collection)).to eq(nil)
  end

  xit'#find all merchants by name' do #FIX THIS!!!
    merchant_repo = @sales_engine.merchants
    collection = merchant_repo.merchants
    merchant = merchant_repo.create({:id => 5,
                                     :name => "Turing School"})
    expect(merchant_repo.find_by_name("Turing Scho", collection)).to eq(merchant)
    expect(merchant_repo.find_all_by_name("Hogwar", collection)).to eq([])
  end

    xit'#create merchant' do
      merchant_repo = @sales_engine.merchants
      merchant_info = {:id => 5,
                       :name => "Turing School"}

      expect(merchant_repo.create(merchant_info)).to be_an_instance_of(Merchant)
    end

    xit'#updates attributes' do
      merchant_repo = @sales_engine.merchants
      merchant = merchant_repo.create({:id => 5,
                                     :name => "Turing School"})

      updated_attributes = {:name => "School of Life"}

      merchant_repo.update(merchant.id, updated_attributes)
      expect(merchant.name).to eq("School of Life")
    end

    xit'#delete merchant' do
      merchant_repo = @sales_engine.merchants
      merchant = merchant_repo.create({:id => 5,
                                       :name => "Turing School"})

      expect(merchant_repo.find_by_id(merchant.id)).to eq(merchant)
      merchant_repo.delete(merchant.id)
      expect(merchant_repo.find_by_id(merchant.id)).to eq(nil)
    end
  end
end

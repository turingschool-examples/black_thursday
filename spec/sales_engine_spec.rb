require 'rspec'
require './lib/sales_engine'
require './lib/merchant_repository'
require './lib/item_repository'
require 'simplecov'
SimpleCov.start

RSpec.describe SalesEngine do
  before(:each) do
    @se = SalesEngine.from_csv({
      :items => './spec/fixtures/item_mock.csv',
      :merchants => './spec/fixtures/merchant_mock.csv',
      :invoices => './spec/fixtures/invoices_mock.csv',
      :invoice_items => './spec/fixtures/invoice_items_mock.csv',
      :customers => './spec/fixtures/customers_mock.csv',
      :transactions => './spec/fixtures/transactions_mock.csv'})
  end

  describe 'instantiation' do
    it 'creates a new sales engine' do

      expect(@se).to be_an_instance_of(SalesEngine)
    end
  end

  describe 'its methods' do
    it 'can return an instance of a merchant repository' do

      expect(@se.merchants).to be_an_instance_of(MerchantRepository)
    end

    it 'can return an instance of a item repository' do

      expect(@se.items).to be_an_instance_of(ItemRepository)
    end

    it 'can list all merchants' do

      expect(@se.merchants.all.count).to eq(5)
    end

    it 'can find merchant by id' do

      expect(@se.find_merchant_by_id(12334123).name).to eq("Keckenbauer")
    end

    it 'can list all the items' do

      expect(@se.items.all.count).to eq(29)
    end

    it 'can find items by id' do

      expect(@se.find_item_by_id(263558510).name).to eq("Tupac")
    end

    it 'can create a sales analyst class' do

      expect(@se.analyst).to be_an_instance_of(SalesAnalyst)
    end
  end
end

require 'rspec'
require './lib/sales_engine'
require './lib/merchant_repository'
require './lib/item_repository'
require 'simplecov'
SimpleCov.start

RSpec.describe do
  before(:each) do
    @se = SalesEngine.from_csv({
      :items => './spec/fixtures/item_fixtures.csv',
      :merchants => './spec/fixtures/merchant_fixtures.csv',
      :invoices => './data/invoices.csv'
      })
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

      expect(@se.merchants.all.count).to eq(10)
    end

    it 'can find merchant by id' do

      expect(@se.find_merchant_by_id(12334382).name).to eq("Keckenbauer")
    end

    it 'can list all the items' do

      expect(@se.items.all.count).to eq(12)
    end

    it 'can find items by id' do

      expect(@se.find_item_by_id(263408574).name).to eq("Adidas Azteca Fußballschuh")
    end

    it 'can create a sales analyst class' do

      expect(@se.analyst).to be_an_instance_of(SalesAnalyst)
    end
  end
end

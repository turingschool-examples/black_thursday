require_relative 'spec_helper'

RSpec.describe SalesEngine do
  before :each do
    @paths = {
      :items     => 'fixture/item_fixture.csv',
      :merchants => 'fixture/merchant_fixture.csv'
    }
    @engine = SalesEngine.new(@paths)
  end

  describe 'instantiation' do

    it 'exists' do
      expect(@engine).to be_a(SalesEngine)
    end
  end

  describe 'Access to repositories' do
    it 'has access to MerchantRepository' do
      expect(@engine.merchants).to be_a(MerchantRepository)
      expect(@engine.all_merchants).to be_an(Array)
    end

    it 'has access to ItemRepository' do
      expect(@engine.items).to be_a(ItemRepository)
      expect(@engine.all_items).to be_an(Array)
    end
  end
end

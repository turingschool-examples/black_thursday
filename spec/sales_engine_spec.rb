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

  describe 'merchant repository' do
    it 'has access to MerchantRepository' do
      expect(@engine.merchants).to be_a(MerchantRepository)
      expect(@engine.all_merchants).to be_an(Array)
    end
  end
end

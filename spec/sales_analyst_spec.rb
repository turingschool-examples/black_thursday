require_relative 'spec_helper'

RSpec.describe 'SalesAnalyst' do
  before :each do
    @sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })
    @sales_analyst = @sales_engine.analyst
  end
  describe 'instantiation' do
    it 'exists' do
      expect(@sales_analyst).to be_a(SalesAnalyst)
    end

    it 'has access to Sales Engine' do
      expect(@sales_engine.merchants).to be_a(MerchantRepository)
      expect(@sales_engine.all_merchants).to be_an(Array)
    end
  end

    describe 'methods' do
      it 'can return the average items per merchant' do
        expect(@sales_analyst.average_items_per_merchant).to eq(2.88)
      end

      it 'can return number of items per merchant' do
        expect(@sales_analyst.number_items_per_merchant).to be_an(Array)
      end


      it 'can return the average items per mechant standard dev' do
        expect(@sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
      end
    end
  end

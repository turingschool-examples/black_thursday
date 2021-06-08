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
        expect(@sales_analyst.number_items_per_merchant).to be_an(Hash)
      end

      it 'can return an average' do
        data = [1, 5, 9]

        expect(@sales_analyst.avg(data)).to eq(5)
      end

      it 'can deviate in a standard way' do
        data = [21, 4224, 17, 8008]

        expect(@sales_analyst.std_dev(data)).to eq(3844.16)
      end

      it 'can return the average items per mechant standard dev' do
        expect(@sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
      end

      it 'can return the merchants that have the most items for sale' do
        expect(@sales_analyst.merchants_with_high_item_count).to be_an(Array)
        expect(@sales_analyst.merchants_with_high_item_count.count).to eq(52)
      end


      # it 'can return the merchants that are 2 standard deviations from the average' do
      #   expect(@sales_analyst.golden_items).to be_an(Array)
      #   expect(@sales_analyst.golden_items.first).to be_a(Item)
      #   expect(@sales_analyst.golden_items.length).to eq(10)
      # end
    end
  end

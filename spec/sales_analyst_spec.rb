require_relative './spec_helper'

RSpec.describe SalesAnalyst do
  context 'instantiation' do
    before :each do
      @se = SalesEngine.new({ items: 'spec/fixtures/items.csv', merchants: 'spec/fixtures/merchants.csv' })
      @analyst = SalesAnalyst.new(@se)
    end

    it 'exists' do
      expect(@analyst).to be_an_instance_of(SalesAnalyst)
    end

    it 'has an engine' do
      expect(@analyst.engine).to eq(@se)
    end
  end

  context 'methods' do
    before :each do
      @se = SalesEngine.new({ items: 'spec/fixtures/items.csv', merchants: 'spec/fixtures/merchants.csv' })
      @analyst = SalesAnalyst.new(@se)
    end

    it 'can calculate average items per merchant' do
      expect(@analyst.average_items_per_merchant).to eq(1.0)
    end

    it 'can calculate number of items per merchant' do
      expected = {
        @se.merchants.all[0] => 1,
        @se.merchants.all[1] => 1,
        @se.merchants.all[2] => 1,
        @se.merchants.all[3] => 1,
        @se.merchants.all[4] => 1,
        @se.merchants.all[5] => 1,
        @se.merchants.all[6] => 1,
        @se.merchants.all[7] => 1,
        @se.merchants.all[8] => 1,
        @se.merchants.all[9] => 1,
        @se.merchants.all[10] => 1,
        @se.merchants.all[11] => 1,
        @se.merchants.all[12] => 1,
        @se.merchants.all[13] => 1,
        @se.merchants.all[14] => 1,
        @se.merchants.all[15] => 1,
        @se.merchants.all[16] => 1,
        @se.merchants.all[17] => 1,
        @se.merchants.all[18] => 1,
        @se.merchants.all[19] => 1
      }

      expect(@analyst.items_per_merchant).to eq(expected)
    end

    it 'can calculate standard deviation' do
      numbers = [4, 5, 6]
      average = 5

      expect(@analyst.standard_dev(numbers, average)).to eq(1.00)
    end

    it 'can calculate standard deviation for items per merchant' do
      expect(@analyst.average_items_per_merchant_standard_deviation).to eq(0.0)
    end

    it 'can calculate the merchants with high item count' do
      expect(@analyst.merchants_with_high_item_count).to eq([])
    end
  end
end

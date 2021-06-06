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
      expected = 
      expect(@analyst.items_per_merchant).to eq(expected)
    end
  end
end

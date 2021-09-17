require './lib/sales_engine'
require 'bigdecimal'

RSpec.describe SalesEngine do
  before :each do
    data = {
      items: './data/items.csv',
      merchants: './data/merchants.csv'
    }
    @se = SalesEngine.from_csv(data)
  end

  context 'Iteration 0' do
    it 'exists' do
      expect(@se).to be_an_instance_of(SalesEngine)
    end

    it 'can access items' do
      expect(@se.items.find_by_name("Disney scrabble frames")).to be_an_instance_of(Item)
    end

    it 'can access merchants' do
      expect(@se.merchants.find_by_name("jejum")).to be_an_instance_of(Merchant)
    end
  end

  context 'Iteration 1' do
    it 'exists' do
      sales_analyst = @se.analyst
      expect(sales_analyst).to be_an_instance_of(SalesAnalyst)
    end
  end
end

require './spec_helper'
require './lib/sales_engine'

RSpec.describe SalesEngine do
  describe '#initialize' do
    it 'exists' do
      se = se = SalesEngine.new({
        :items     => './data/items.csv',
        :merchants => './data/merchants.csv'})

      expect(se).to be_a(SalesEngine)
    end
  end

  describe '#items' do
    it 'creates and returns an item repository object' do
      se = se = SalesEngine.new({
        :items     => './data/items.csv',
        :merchants => './data/merchants.csv'})

      ir = se.items

      expect(ir).to be_a(ItemRepository)
    end
  end
end

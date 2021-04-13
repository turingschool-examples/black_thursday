require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/item_repository'

RSpec.describe ItemRepository do
  before do
    @se = SalesEngine.new
    @ir = @se.items
  end

  describe '#initialize' do
    it 'exists' do
      expect(@ir).to be_instance_of(ItemRepository)
    end

    it 'has items' do
      # binding.pry
      expect(@ir.items.count).to eq(1367)
    end
  end

  describe '#make items' do
    it 'makes items' do
      expect(@ir.make_items(@se.make_hash('./data/items.csv')).first).to be_instance_of(Item)
    end
  end
end

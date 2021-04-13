require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/item_repository'
# require './lib/item'

RSpec.describe Item do
  before do
    @se = SalesEngine.new
    @ir = @se.items
    @item = @ir.items[0]
  end
  describe '#initialize' do
    it 'exists' do
      expect(@item).to be_instance_of(Item)
    end
    it 'has attributes' do
        expect(@ir.id).to be_instance_of(ItemRepository)
        expect(@ir.name).to be_instance_of(ItemRepository)
        expect(@ir.description).to be_instance_of(ItemRepository)
        expect(@ir.unit_price).to be_instance_of(ItemRepository)
        expect(@ir.created_at).to be_instance_of(ItemRepository)
        expect(@ir.updated_at).to be_instance_of(ItemRepository)
        expect(@ir.merchant_id).to be_instance_of(ItemRepository)
      end
  end
end

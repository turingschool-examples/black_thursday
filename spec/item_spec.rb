require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/item_repository'
require 'pry'
# require './lib/item'

RSpec.describe Item do
  before do
    @se = SalesEngine.new
    @ir = @se.items
    @item = @ir.items.first
  end
  describe '#initialize' do
    it 'exists' do
      # binding.pry
      expect(@item).to be_instance_of(Item)
    end
    it 'has attributes' do
        expect(@item.id).to eq(263395237)
        expect(@item.name).to eq("510+ RealPush Icon Set")
        expect(@item.description.length).to eq(2237)
        expect(@item.unit_price).to eq(0.12e4)
        expect(@item.created_at).to eq("2016-01-11 09:34:06 UTC")
        expect(@item.updated_at).to eq("2007-06-04 21:35:10 UTC")
        expect(@item.merchant_id).to eq("12334141")
      end
  end
end

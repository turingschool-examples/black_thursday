require './lib/item'
require 'simplecov'
require 'bigdecimal'

SimpleCov.start

RSpec.describe Item do
  before :each do
    @i = Item.new({
                    :id => 1,
                    :name => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price => BigDecimal(10.99, 4),
                    :created_at => Time.now,
                    :updated_at => Time.now,
                    :merchant_id => 2
                  })
  end
  describe 'Item' do
    it 'exists' do
      expect(@i).to be_a(Item)
    end

    it 'has attributes' do
      expect(@i.id).to eq(1)
      expect(@i.name).to eq("Pencil")
      expect(@i.description).to eq("You can use it to write things")
      expect(@i.unit_price).to eq(0.1099e2)
      expect(@i.created_at).to be_a(Time)
      expect(@i.updated_at).to be_a(Time)
      expect(@i.merchant_id).to eq(2)
    end
  end

  describe 'Item methods' do
    it 'returns a unit_price to dollars' do
      expect(@i.unit_price_to_dollars).to eq(10.99)
      expect(@i.unit_price_to_dollars).to be_a(Float)
    end
  end
end

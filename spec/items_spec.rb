require 'rspec'
require './lib/items'
require 'BigDecimal'

describe Item do
  before(:each) do

    @item = {
  :id          => 1,
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal(10.99,4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
  :merchant_id => 2
}
    @item1 = Item.new(@item)
  end

  it 'exists' do

  expect(@item1).to be_a(Item)
  end

  describe 'id' do
    it 'returns the id' do

      expect(@item1.id).to eq(1)
    end
  end

  describe 'name' do
    it 'returns the name' do

      expect(@item1.name).to eq('Pencil')
    end
  end

  describe 'description' do
    it 'returns the description' do

      expect(@item1.description).to eq("You can use it to write things")
    end
  end

  describe 'unit_price' do
    it 'returns the unit_price' do

      expect(@item1.unit_price).to eq(BigDecimal(10.99,4))
    end
  end

  describe 'created_at' do
    it 'returns the created_at' do

      expect(@item1.created_at).to eq(@item[:created_at])
    end
  end

  describe 'updated_at' do
    it 'returns the updated_at' do

      expect(@item1.updated_at).to eq(@item[:updated_at])
    end
  end

  describe 'merchant_id' do
    it 'returns the merchant_id' do

      expect(@item1.merchant_id).to eq(2)
    end
  end

  describe 'unit_price_to_dollars' do
    it 'converts unit price to dollars in float format' do

      expect(@item1.unit_price_to_dollars).to eq(10.99)
    end
  end
end

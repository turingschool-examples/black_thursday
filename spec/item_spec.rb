require 'rspec'
require_relative './lib/item'

describe Item do
  i = Item.new({
                :id          => 1,
                :name        => "Pencil",
                :description => "You can use it to write things",
                :unit_price  => BigDecimal(10.99,4),
                :created_at  => Time.now,
                :updated_at  => Time.now,
                :merchant_id => 2
              })
  describe '.initialize' do
    it 'exists' do
      expect(i).to be_a Item
    end

    it 'has an id' do
      expect(i.id).to be 1
    end

    it 'has a name' do
      expect(i.name).to eq("Pencil")
    end

    it 'has a description' do
      expect(i.description).to eq("You can use it to write things")
    end

    it 'has a price' do
      expect(i.unit_price).to eq(0.1099e2)
    end

    it 'has a Time for the date it was created' do
      expect(i.created_at).to be_a(Time)
    end

    it 'has a time for the date it was updated' do
      expect(i.updated_at).to be_a(Time)
    end

    it 'has a merchant id' do
      expect(i.merchant_id).to be 2
    end
  end

  describe 'unit_price_to_dollars' do
    it 'converts the unit_price to a float' do
      expect(i.unit_price_to_dollars).to eq(10.99)
    end
  end
end

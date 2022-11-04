require_relative '../lib/item'
require 'bigdecimal'

RSpec.describe Item do
  let(:i) { Item.new({
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(10.99,4),
        # Change Time.now to Time.now.to_s? to pass our tests
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 2}) }

  describe '#initialize' do
    it 'exists' do
      expect(i).to be_a(Item)
    end

    it 'has an id' do 
      expect(i.id).to eq(1)
    end

    it 'has a name' do 
      expect(i.name).to eq("Pencil")
    end

    it 'has a description' do 
      expect(i.description).to eq("You can use it to write things")
    end

    it 'has an unit price' do 
      expect(i.unit_price).to eq(10.99)
    end

    it 'logs a created_at time' do 
      expect(i.created_at).to be_a(Time)
    end

    it 'starts with an updated_at time' do 
      expect(i.updated_at).to be_a(Time)
    end

    it 'has a merchant id' do 
      expect(i.merchant_id).to eq(2)
    end
  end  

  describe '#unit_price_to_dollars' do
    it 'returns price of item in dollars as float' do
      expect(i.unit_price_to_dollars).to eq(10.99)
      expect(i.unit_price_to_dollars.class).to eq(Float)
    end
  end  
end
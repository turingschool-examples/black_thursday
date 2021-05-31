require './lib/item'
require 'rspec'
require 'simplecov'
require 'bigdecimal'

SimpleCov.start

RSpec.describe Item do

  before :each do
    @i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })
  end

  describe 'Object Creation' do

    it 'exists' do
      expect(@i).to be_a(Item)
    end

    it 'has readable attributes' do
      expect(@i.id).to eq(1)
      expect(@i.name).to eq("Pencil")
      expect(@i.description).to eq("You can use it to write things")
      expect(@i.unit_price).to eq(BigDecimal(10.99,4))
      expect(@i.created_at).to be_a(Time)
      expect(@i.updated_at).to be_a(Time)
      expect(@i.merchant_id).to eq(2)
    end

  end

  describe 'Object Methods' do

    it 'returns the unit price to dollars' do
      expect(@i.unit_price_to_dollars).to eq(10.99)
      expect(@i.unit_price_to_dollars).to be_a(Float)
    end

    it 'can update the Item with provided attributes' do
      attributes = {
        name: "Mechanical Pencil",
        description: "You can use it to write things and refill it with lead",
        unit_price: BigDecimal(1.99,3)
      }

      intitial_update_time = @i.updated_at
      @i.update(attributes)

      expect(@i.id).to eq(1)
      expect(@i.name).to eq("Mechanical Pencil")
      expect(@i.description).to eq("You can use it to write things and refill it with lead")
      expect(@i.unit_price).to eq(BigDecimal(1.99,3))
      expect(@i.updated_at).to be_a(Time)
      expect(@i.updated_at).not_to eq(intitial_update_time)
      expect(@i.merchant_id).to eq(2)

      attributes = {
        name: "Pencil",
        description: "You can use it to write things"
      }

      intitial_update_time = @i.updated_at
      @i.update(attributes)

      expect(@i.id).to eq(1)
      expect(@i.name).to eq("Pencil")
      expect(@i.description).to eq("You can use it to write things")
      expect(@i.unit_price).to eq(BigDecimal(1.99,3))
      expect(@i.updated_at).to be_a(Time)
      expect(@i.updated_at).not_to eq(intitial_update_time)
      expect(@i.merchant_id).to eq(2)
    end

  end

end

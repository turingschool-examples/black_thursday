require_relative 'spec_helper'

RSpec.describe Item do
  before :each do
    item_data = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }
    @item = Item.new(item_data)
  end

  describe 'instantiation' do
    it 'exists' do
      expect(@item).to be_a(Item)
    end

    it 'has readable attributes' do
      expect(@item.id).to eq(1)
      expect(@item.name).to eq("Pencil")
      expect(@item.description).to eq("You can use it to write things")
      expect(@item.unit_price).to eq(0.1099e2)
      expect(@item.created_at).to be_an_instance_of(Time)
      expect(@item.updated_at).to be_an_instance_of(Time)
      expect(@item.merchant_id).to eq(2)
    end
  end

  describe 'methods' do
    it 'returns unit price to dollars as a float' do
      expect(@item.unit_price_to_dollars).to eq(10.99)
    end
  end
end

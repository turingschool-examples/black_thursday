require './lib/item'
require 'bigdecimal'

describe Item do
  before(:each) do
    @item_list = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }

    @item = Item.new(@item_list)
  end

  it 'exists' do
    expect(@item).to be_instance_of(Item)
  end

  describe '#getters' do
    it 'returns item id' do
      expect(@item.id).to eq(1)
    end

    it 'returns item name' do
      expect(@item.name).to eq("Pencil")
    end

    it 'returns item description' do
      expect(@item.description).to eq("You can use it to write things")
    end

    it 'returns item unit price' do
      expect(@item.unit_price).to eq(BigDecimal(10.99,4))
    end

    it 'returns item creation date' do
      expect(@item.created_at).to be_instance_of(Time)
    end

    it 'returns item updated date' do
      expect(@item.updated_at).to be_instance_of(Time)
    end

    it 'returns item merchant id' do
      expect(@item.merchant_id).to eq(2)
    end

    it 'returns item unit price converted to money format' do
      expect(@item.unit_price_to_dollars).to eq(10.99)
    end
  end
end
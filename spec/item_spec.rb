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
  end
end
require './lib/item'
require './lib/item_repository'
require 'bigdecimal'

describe ItemRepository do
  before(:each) do
    @items1 = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }
    @items2 = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }

    @item1 = Item.new(@items1)
    @item2 = Item.new(@items2)

    @ir = ItemRepository([@item1, @item2])
  end

  it 'exists' do
    expect(@ir).to be_instance_of(ItemRepository)
  end
end
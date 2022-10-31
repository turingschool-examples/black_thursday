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

    @item = Item.new(item_list)
  end

  it 'exists' do
    expect(item).to be_instance_of(Item)
  end
end
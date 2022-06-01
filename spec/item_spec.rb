require './lib/merchant'
require './lib/item'
require 'bigdecimal'

RSpec.describe Item do
  it 'initialize item' do
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
      })
    expect(i).to be_instance_of Item
  end

  it 'return price of item in dollars' do
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
      })
    expect(i.unit_price_to_dollars).to eq(23.48)
  end

end

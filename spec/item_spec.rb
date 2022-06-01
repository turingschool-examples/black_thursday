require './lib/item.rb'
require 'BigDecimal'
RSpec.describe Item do

    i = Item.new({
  :id          => 1,
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal(10.99,4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
  :merchant_id => 2
})

  it 'exists' do
  expect(i).to be_a(Item)
  end

  it 'item has attributes' do
    time = Time.new
    expect(i.id).to eq(1)
    expect(i.name).to eq("Pencil")
    expect(i.description).to eq("You can use it to write things")
    expect(i.unit_price).to eq(BigDecimal(10.99,4))
    expect(i.created_at).to eq(time)
    expect(i.updated_at).to eq(time)
    expect(i.merchant_id).to eq(2)
  end
  it 'returns the price of the item in dollars' do
    expect(i.unit_price_to_dollars).to eq(10.99)
  end
end

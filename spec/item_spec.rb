require './lib/item'
require 'bigdecimal'
require 'time'

RSpec.describe 'Item' do
  item = Item.new({
    :id => 1,
    :name => "Pencil",
    :description => "You can use it to write things",
    :unit_price => BigDecimal(10.99,4),
    :created_at => Time.now,
    :updated_at => Time.now,
    :merchant_id => 2
  })

  puts BigDecimal(10.99,4)

  it 'exists' do
    expect(item).to be_an_instance_of(Item)
  end

  it 'has all expected attributes' do
    expect(item.item_attributes[:id]).to eq(1)
    expect(item.item_attributes[:name]).to eq("Pencil")
    expect(item.item_attributes[:description]).to eq("You can use it to write things")
    expect(item.item_attributes[:unit_price]).to eq(BigDecimal(10.99,4))
    expect(item.item_attributes[:created_at]).to be_an_instance_of(Time)
    expect(item.item_attributes[:updated_at]).to be_an_instance_of(Time)
    expect(item.item_attributes[:merchant_id]).to eq(2)
  end

  it 'can convert unit price to dollars' do
    expect(item.unit_price_to_dollars).to eq(10.99)
  end

end

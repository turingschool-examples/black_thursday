require './lib/item'
require 'bigdecimal'

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
    expect(item.id).to eq(1)
    expect(item.name).to eq("Pencil")
    expect(item.description).to eq("You can use it to write things")
    expect(item.unit_price).to eq(BigDecimal(10.99,4))
    expect(item.created_at).to eq(item.updated_at)
    expect(item.merchant_id).to eq(2)
  end
end
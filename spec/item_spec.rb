require './lib/item'
require 'bigdecimal'

RSpec.describe Item do
  before(:each) do
    @time = Time.now
    @item = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => @time,
      :updated_at  => @time,
      :merchant_id => 2
    })
  end

  it 'exists' do
    expect(@item).to be_a(Item)
  end

  it 'has an id' do
    expect(@item.id).to eq 1
  end

  it 'has a name' do
    expect(@item.name).to eq("Pencil")
  end

  it 'has a description' do
    expect(@item.description).to eq("You can use it to write things")
  end

  it 'has a unit price' do
    expect(@item.unit_price).to eq(BigDecimal(10.99,4))
  end

  it 'has a time created at' do
    expect(@item.created_at).to eq(@time)
  end

  it 'has a time updated at' do
    expect(@item.updated_at).to eq(@time)
  end

  it 'has a merchant id' do
    expect(@item.merchant_id).to eq 2
  end

  it 'knows the unit price to dollars' do
    expect(@item.unit_price_to_dollars).to eq 10.99
  end
end

require './lib/item'
require 'bigdecimal'

RSpec.describe Item do
  before(:each) do
    @time = Time.now
    @i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => @time,
      :updated_at  => @time,
      :merchant_id => 2
    })
  end

  it '#initialize' do

    expect(@i).to be_an_instance_of(Item)
  end

  it 'has id' do
    expect(@i.id).to eq(1)
  end

  it 'has a name' do
    expect(@i.name).to eq("Pencil")
  end

  it 'has a description' do
    expect(@i.description).to eq("You can use it to write things")
  end

  it 'has a unit price' do
    expect(@i.unit_price).to eq(BigDecimal(10.99,4))
    require 'pry'; binding.pry
  end

  it 'has a date of creation' do
    expect(@i.created_at).to eq(@time)
  end

  it 'has a date of update' do
    expect(@i.updated_at).to eq(@time)
  end

  it 'has a merchant id' do
    expect(@i.merchant_id).to eq(2)
  end

  xit 'can convert unit price to dollars' do
    expect(@i.unit_price_to_dollars).to eq(23.48)
  end
end

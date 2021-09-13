require "Rspec"
require "bigdecimal"
require "./lib/item"

describe Item do
  before :each do
    @i = Item.new({
      :id          => 1,
      :name        => 'Pencil',
      :description => 'You can use it to write things',
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })
  end

  it 'is an item' do
    expect(@i).to be_a Item
  end

  it '#id' do
    expect(@i.id).to eq 1
  end

  it '#name' do
    expect(@i.name).to eq 'Pencil'
  end

  it '#description' do
    expect(@i.description).to eq 'You can use it to write things'
  end

  it '#unit_price' do
    expect(@i.unit_price).to eq 0.1099e2
  end

  it '#created_at' do
    expect(@i.created_at).to be_a Time
  end

  it '#updated_at' do
    expect(@i.updated_at).to be_a Time
  end

  it '#merchant_id' do
    expect(@i.merchant_id).to eq 2
  end

  it '#unit_price_to_dollars' do
    expect(@i.unit_price_to_dollars).to eq 10.99
  end
end

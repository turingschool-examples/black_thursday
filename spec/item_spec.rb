require 'SimpleCov'
SimpleCov.start

require_relative '../lib/item'
require 'bigdecimal'

RSpec.describe Item do
  it 'exists' do
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10,4),
      :created_at  => Time.now.to_s,
      :updated_at  => Time.now.to_s,
      :merchant_id => 2
    })

    expect(i).to be_an_instance_of(Item)
  end

  it 'initializes with attributes' do
    data = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now.to_s,
      :updated_at  => Time.now.to_s,
      :merchant_id => 2
    }
    i = Item.new(data)

    expect(i.id).to eq(data[:id])
    expect(i.name).to eq(data[:name])
    expect(i.description).to eq(data[:description])
    # expect(i.unit_price).to eq(data[:unit_price])
    # expect(i.created_at).to eq(data[:created_at])
    # expect(i.updated_at).to eq(data[:updated_at])
    expect(i.merchant_id).to eq(data[:merchant_id])
  end


  it 'Returns the item price in dollars' do
    data = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now.to_s,
      :updated_at  => Time.now.to_s,
      :merchant_id => 2
    }
    data2 = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(12000),
      :created_at  => Time.now.to_s,
      :updated_at  => Time.now.to_s,
      :merchant_id => 2
    }

    i = Item.new(data)
    i2 = Item.new(data2)
    expect(i2.unit_price).to eq(12000)
    expect(i.unit_price_to_dollars).to eq(10.99)
  end
end

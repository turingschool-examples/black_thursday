require 'rspec'
require 'bigdecimal'
require './lib/item'

describe Item do 
  it 'exists' do 
    details = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }
    item = Item.new(details)

    expect(item).is_a? Item 
  end

  it 'has an id' do 
    details = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }
    item = Item.new(details)

    expect(item.id).to eq 1
    expect(item.id).is_a? Integer
  end
end
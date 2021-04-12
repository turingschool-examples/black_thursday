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

  it 'has a name' do
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

    expect(item.name).to eq "Pencil"
    expect(item.name).is_a? String
  end

  it 'has a description' do
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

    expect(item.description).to eq "You can use it to write things"
    expect(item.description).is_a? String
  end

  it 'has a unit price' do
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

    expect(item.unit_price).to eq BigDecimal.new(10.99,4)
    expect(item.unit_price).is_a? BigDecimal
  end

  it 'has a created_at Time' do
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

    expect(item.created_at).is_a? Time
  end

  it 'has a updated_at Time' do
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

    expect(item.updated_at).is_a? Time
  end

  it 'has a merchant_id' do 
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

    expect(item.merchant_id).to eq 2
    expect(item.merchant_id).is_a? Integer
  end
end
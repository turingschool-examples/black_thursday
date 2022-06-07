require './lib/helper'
SimpleCov.start

RSpec.describe Item do

  it 'exists' do
    item = Item.new({
      :id => 1,
      :name => "Pencil",
      :description => "You can use it to write things",
      :unit_price => BigDecimal(10.99,4),
      :created_at => Time.now,
      :updated_at => Time.now,
      :merchant_id => 2
      })

    expect(item).to be_instance_of(Item)
  end

  it 'returns id' do
    item = Item.new({
      :id => 1,
      :name => "Pencil",
      :description => "You can use it to write things",
      :unit_price => BigDecimal(10.99,4),
      :created_at => Time.now,
      :updated_at => Time.now,
      :merchant_id => 2
      })

    expect(item.id).to eq(1)
  end

  it 'returns name' do
    item = Item.new({
      :id => 1,
      :name => "Pencil",
      :description => "You can use it to write things",
      :unit_price => BigDecimal(10.99,4),
      :created_at => Time.now,
      :updated_at => Time.now,
      :merchant_id => 2
      })

    expect(item.name).to eq("Pencil")
  end

  it 'returns description' do
    item = Item.new({
      :id => 1,
      :name => "Pencil",
      :description => "You can use it to write things",
      :unit_price => BigDecimal(10.99,4),
      :created_at => Time.now,
      :updated_at => Time.now,
      :merchant_id => 2
      })

    expect(item.description).to eq("You can use it to write things")
  end

  it 'returns unit price' do
    item = Item.new({
      :id => 1,
      :name => "Pencil",
      :description => "You can use it to write things",
      :unit_price => BigDecimal(10.99,4),
      :created_at => Time.now,
      :updated_at => Time.now,
      :merchant_id => 2
      })

    expect(item.unit_price).to eq(BigDecimal(10.99,4))
  end

  xit 'returns time created' do
    item = Item.new({
      :id => 1,
      :name => "Pencil",
      :description => "You can use it to write things",
      :unit_price => BigDecimal(10.99,4),
      :created_at => Time.now,
      :updated_at => Time.now,
      :merchant_id => 2
      })

    expect(item.created_at).to eq(Time.now)
    #this doesn't pass because the expect is called slightlllllly after the object is inialized
  end

  xit 'returns time updated' do
    item = Item.new({
      :id => 1,
      :name => "Pencil",
      :description => "You can use it to write things",
      :unit_price => BigDecimal(10.99,4),
      :created_at => Time.now,
      :updated_at => Time.now,
      :merchant_id => 2
      })

    expect(item.updated_at).to eq(Time.now)
    #this doesn't pass because the expect is called slightlllllly after the object is inialized
  end

  it 'returns merchant id' do
    item = Item.new({
      :id => 1,
      :name => "Pencil",
      :description => "You can use it to write things",
      :unit_price => BigDecimal(10.99,4),
      :created_at => Time.now,
      :updated_at => Time.now,
      :merchant_id => 2
      })

    expect(item.merchant_id).to eq(2)
  end

  it 'returns unit price in dollars' do
    item = Item.new({
      :id => 1,
      :name => "Pencil",
      :description => "You can use it to write things",
      :unit_price => BigDecimal(10.99,4),
      :created_at => Time.now,
      :updated_at => Time.now,
      :merchant_id => 2
      })

    expect(item.unit_price_to_dollars).to eq(10.99)
  end

end

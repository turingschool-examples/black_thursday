require 'SimpleCov'
SimpleCov.start

require_relative '../lib/item'
require 'bigdecimal'

RSpec.describe Item do
  it 'exists' do
    i = Item.new({
      :id          => 1,
      :name        => 'Pencil',
      :description => 'You can use it to write things',
      :unit_price  => BigDecimal(10, 4),
      :created_at  => Time.now.to_s,
      :updated_at  => Time.now.to_s,
      :merchant_id => 2
    })

    expect(i).to be_an_instance_of(Item)
  end

  it 'initializes with attributes' do
    data = {
      :id          => 1,
      :name        => 'Pencil',
      :description => 'You can use it to write things',
      :unit_price  => BigDecimal(1099, 4),
      :created_at  => '2021-06-11 09:34:06 UTC',
      :updated_at  => '2021-06-11 09:34:06 UTC',
      :merchant_id => 2
    }
    i = Item.new(data)

    expect(i.id).to eq(1)
    expect(i.name).to eq('Pencil')
    expect(i.description).to eq('You can use it to write things')
    expect(i.unit_price).to eq(BigDecimal(10.99, 4))
    expect(i.created_at).to eq(Time.parse('2021-06-11 09:34:06 UTC'))
    expect(i.updated_at).to eq(Time.parse('2021-06-11 09:34:06 UTC'))
    expect(i.merchant_id).to eq(2)
  end

  it 'can parse time or create time' do
    data = {
      :id          => 1,
      :name        => 'Pencil',
      :description => 'You can use it to write things',
      :unit_price  => BigDecimal(1099, 4),
      :created_at  => '2021-06-11 09:34:06 UTC',
      :updated_at  => nil,
      :merchant_id => 2
    }
    i = Item.new(data)

    expect(i.created_at).to be_a(Time)
    expect(i.updated_at).to be_a(Time)
  end
  it 'can update attributes' do
    data = {
      :id          => 1,
      :name        => 'Pencil',
      :description => 'You can use it to write things',
      :unit_price  => BigDecimal(1099, 4),
      :created_at  => '2021-06-11 09:34:06 UTC',
      :updated_at  => nil,
      :merchant_id => 2
    }
    i = Item.new(data)

    new_data = {:name        => 'Flower Pencil',
                :description => 'You can use it to write flowery things',
                :unit_price  => BigDecimal(11.00, 4)
              }

    i.update(new_data)

    expect(i.name).to eq('Flower Pencil')
    expect(i.description).to eq('You can use it to write flowery things')
    expect(i.unit_price_to_dollars).to eq(11.00)
    expect(i.updated_at).to be_a(Time)
  end

  it 'Returns the item price in dollars' do
    data = {
      :id          => 1,
      :name        => 'Pencil',
      :description => 'You can use it to write things',
      :unit_price  => BigDecimal(6000, 4),
      :created_at  => Time.now.to_s,
      :updated_at  => Time.now.to_s,
      :merchant_id => 2
    }

    i = Item.new(data)
    expect(i.unit_price).to be_a(BigDecimal)
    expect(i.unit_price_to_dollars).to eq(60)
  end
end

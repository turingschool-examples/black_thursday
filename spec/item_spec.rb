require 'simplecov'
SimpleCov.start
require './lib/item'
require 'pry'
require 'time'

RSpec.describe Item do
  let(:i) do
    Item.new({
               id: 1,
               name: 'Pencil',
               description: 'You can use it to write things',
               unit_price: BigDecimal(10.99, 4),
               created_at: Time.now,
               updated_at: Time.now,
               merchant_id: 2
             })
  end

it '#initialize' do
    expect(i).to be_instance_of(Item)
    expect(i.id).to eq(1)
    expect(i.name).to eq('Pencil')
    expect(i.description).to eq('You can use it to write things')
    expect(i.unit_price).to eq(10.99)
    expect(i.created_at).to be_instance_of(Time)
    expect(i.updated_at).to be_instance_of(Time)
    expect(i.merchant_id).to eq(2)
  end

  it '#to_price' do
  expect(i.to_price("10.99")).to eq(10.99)
  end

  it '#unit_price_to_dollars' do
    expect(i.unit_price_to_dollars).to eq(10.99)
  end

  it '#update' do
    i.update({
      name: 'Paint Brush',
      description: 'You can use it to paint things',
      unit_price: BigDecimal(12.99, 4)
    })
    expect(i.name).to eq('Paint Brush')
    expect(i.description).to eq('You can use it to paint things')
    expect(i.unit_price_to_dollars).to eq(12.99)
  end
end

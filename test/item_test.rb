require 'simplecov'
SimpleCov.start
require './lib/item'
require 'rspec'
require 'bigdecimal'

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

end

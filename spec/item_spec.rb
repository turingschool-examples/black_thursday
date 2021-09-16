require './lib/item'
require './lib/sales_engine'
require 'csv'
require 'bigdecimal'


RSpec.describe do

  # before(:each) do

  it 'exists' do
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
                 })

    expect(i).to be_an_instance_of(Item)
  end

  it 'returns an integer id' do
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
                 })

    expect(i.id).to eq(1)
    expect(i.id).to be_an(Integer)
  end
end

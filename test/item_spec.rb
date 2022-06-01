require './lib/item'
require 'BigDecimal'

RSpec.describe Item do
  before :each do
    @i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })
  end

  it 'exists' do
    expect(@i).to be_a(Item)
  end

  it 'converts unit price to dollars' do
    expect(@i.unit_price_to_dollars).to eq(10.99)
  end
end

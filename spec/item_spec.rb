require './lib/items.rb'

RSpec.describe Item do

    i = Item.new({
  :id          => 1,
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal(10.99,4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
  :merchant_id => 2
})

  it 'exists' do
  expect(i).to be_a(Item)
  end
  
end

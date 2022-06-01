require './lib/item'
require 'BigDecimal'
# require Time

describe Item do
  before(:each) do
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

  it "is an item" do
  expect(@i).to be_a(Item)
  end


end

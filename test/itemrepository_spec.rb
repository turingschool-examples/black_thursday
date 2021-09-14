require './lib/item.rb'
require './lib/itemrepository.rb'
require 'bigdecimal'

RSpec.describe ItemRepository do
  it "can return an array of all know Item instances" do
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
      })


  expect()
  end
end

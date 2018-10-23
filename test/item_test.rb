require_relative './helper'
require_relative '../lib/item'

class ItemTest < Minitest::Test

def test_item_exists
  i = Item.new({
  :id          => 1,
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal.new(10.99,4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
  :merchant_id => 2
})
  assert_instance_of Item, i 
end

end

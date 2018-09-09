require './test/minitest_helper'
require './lib/item'
require 'bigdecimal'
require Time

class ItemTest<Minitest::Test

def test_it_exists
  i = Item.new({
    :id          => 1,
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => TIme.now,
    :merchant_id => 2
    })

    assesrt_instance_of Item, i
end

end

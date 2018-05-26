require './test/test_helper'
require './lib/item'
require 'bigdecimal'

class ItemTest < Minitest::Test

  def test_it_exits
    args = {
            :name        => "Pencil",
            :description => "You can use it to write things",
            :unit_price  => BigDecimal.new(10.99,4),
            :created_at  => Time.now,
            :updated_at  => Time.now,
            }
    item = Item.new(args)
    assert_instance_of Item, item
  end


end

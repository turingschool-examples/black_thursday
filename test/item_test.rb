require './test/test_helper'
require './lib/item'

class ItemTest < Minitest::Test
  def test_it_exists
    item = Item.new
    assert_instance_of Item, item
  end
end

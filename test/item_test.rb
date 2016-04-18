require './test/test_helper'
require './lib/item'

class ItemTest < Minitest::Test
  def test_it_created_instance_of_item_class
    i = Item.new
    assert_equal Item, i.class
  end
end

require_relative 'test_helper'

require_relative '../lib/item.rb'

class ItemTest < Minitest::Test
  def test_does_create_item
    item = Item.new

    assert_instance_of Item, item
  end
end

require 'minitest/autorun'
require 'minitest/emoji'
require './lib/item'
class ItemTest < Minitest::Test
  def test_it_exists
    it = Item.new

    assert_instance_of Item, it
  end


end

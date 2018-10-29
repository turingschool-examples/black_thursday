require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class ItemTest < Minitest::Test
  def test_it_exists
    i = Item.new
    assert_instance_of Item, i
  end

  def test_it_has_an_id
    i = Item.new
    assert_equal 1, i.id
  end

end

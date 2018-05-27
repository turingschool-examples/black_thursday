require './test/test_helper.rb'
require './lib/item.rb'

class ItemTest < Minitest::Test

  def test_it_exists
    item = Item.new("table")
    assert_instance_of Item, item
  end

  def test_it_is_an_item
    item = Item.new("table")
    assert_equal "table", item.item
  end

end

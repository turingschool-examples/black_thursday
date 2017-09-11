require "./test/test_helper"
require "./lib/item"

class ItemTest < Minitest::Test

  attr_reader :item

  def setup
    @item = Item.new
  end

  def test_it_exists
    assert_instance_of Item, item
  end

end

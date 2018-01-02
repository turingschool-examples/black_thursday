require './test/test_helper'
require './lib/item'

class ItemTest < Minitest::Test

  def test_item_exists
    item = Item.new("1", "name", "description", "unit_price", "merchant_id", "created_at", "updated_at")

    assert_instance_of Item, item
  end

end

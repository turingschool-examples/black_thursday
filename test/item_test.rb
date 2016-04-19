require './test/test_helper'
require './lib/sales_engine'
require './lib/item'


class ItemTest < Minitest::Test

  def test_setup
    assert Item.new.class
  end
end

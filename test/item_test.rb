require './test/test_helper'
require './lib/item'
require './lib/sales_engine'



class ItemTest < Minitest::Test

  def test_setup
    assert Item.new.class
  end
end

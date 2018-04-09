require_relative 'test_helper'
require_relative '../lib/item'

class ItemTest < Minitest::Test

  def setup
    @item = Item.new
  end

  def test_it_exists
    assert_instance_of Item, @item
  end
end
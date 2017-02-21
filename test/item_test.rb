require "minitest/autorun"
require "minitest/pride"
require "./lib/item"
require "simplecov"
SimpleCov.start

class ItemTest < Minitest::Test
  def test_it_exists
    i = Item.new
    assert_instance_of Item, i
  end
end



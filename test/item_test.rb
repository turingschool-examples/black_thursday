require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class ItemTest < Minitest::Test

  def test_it_exist
    item = Item.new

    assert_instance_of Item, item
  end




end

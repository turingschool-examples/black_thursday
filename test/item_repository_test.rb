require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/item_repository'
require './lib/sales_engine'

class ItemRepositoryTest < Minitest::Test

  def test_it_exists_and_has_attributes
    parent = Minitest::Mock.new 
    ir = ItemRepository.new("./data/items.csv", parent)
    assert_instance_of ItemRepository, ir
    assert_equal "./data/items.csv", ir.path
  end
end

require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    ir = ItemRepository.new("./data/items.csv")

    assert_instance_of ItemRepository, ir
  end

  def test_all_returns_array_of_all_items
    ir = ItemRepository.new("./data/items.csv")

    assert_instance_of Item, ir.all[0]
    assert_equal 1367, ir.all.count
  end

  def test_it_can_find_an_item_by_id
    ir = ItemRepository.new("./data/items.csv")
    
    assert_equal ir.all[2], ir.find_by_id("263395721")
  end
end

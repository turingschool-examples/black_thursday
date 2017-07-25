require './lib/item'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'


class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    ir = ItemRepository.new("./data/items.csv")

    assert_instance_of ItemRepository, ir
  end

  def test_all_returns_all_items_in_the_correct_format
      ir = ItemRepository.new("./data/items.csv")

      assert_instance_of Item, ir.items[0]
      assert_equal 'Shopin1901', ir.items[0].name
      assert_equal 12334105, ir.items[0].id
      assert_equal 475, ir.items.count
  end

end

require './test/test_helper'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    ir = ItemRepository.new('./data/items.csv', self)

    assert_instance_of ItemRepository, ir
  end

  def test_it_initializes_with_populated_array
    ir = ItemRepository.new('./data/items.csv', self)

    assert_equal 1367, ir.items.count
  end

end
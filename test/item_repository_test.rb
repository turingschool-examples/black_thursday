require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'

class ItemRepositoryTest < MiniTest::Test
  def test_it_exists
    ir = ItemRepository.new('./data/items_fixture.csv')

    assert_instance_of ItemRepository, ir
  end

  def test_it_can_parse_data
    ir = ItemRepository.new('./data/items_fixture.csv')

    assert ir.items.length > 0
  end

  #add tests for the specific info.

end

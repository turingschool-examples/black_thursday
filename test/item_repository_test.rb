require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def test_it_exists
    ir = ItemRepository.new

    assert_instance_of ItemRepository, ir
  end

  def test_all_returns_array_of_instances
    ir = ItemRepository.new

     assert_equal 1367, ir.all
  end
end

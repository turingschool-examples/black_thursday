require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'

class ItemRepositoryTest
  def test_it_exists
    ir = ItemRepository.new

    assert_instance_of ItemRepository, ir
  end
end

require_relative 'test_helper'
require_relative '../lib/item_repo'

class ItemRepositoryTest < Minitest::Test
  def test_item_exists
    item = ItemRepository.new

    assert_instance_of ItemRepository, item
  end
  def test
    
  end
end

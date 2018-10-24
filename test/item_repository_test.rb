require_relative './helper'
require_relative '../lib/item_repository'
require_relative '../lib/item'

class ItemRepositoryTest < Minitest::Test
  def test_it_exists
    ir = ItemRepository.new('./data/items_mini.csv')
    assert_instance_of ItemRepository, ir
  end

end

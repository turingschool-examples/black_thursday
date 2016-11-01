require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def test_it_can_create_item_repository
    repository = ItemRepository.new('fixture/items.csv')
    assert repository
  end

end


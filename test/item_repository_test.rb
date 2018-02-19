require_relative 'test_helper'
require_relative '../lib/item_repository'
require 'bigdecimal'

class ItemRepositoryTest < Minitest::Test
  def test_it_exists
    item_repository = ItemRepository.new('./data/items.rb')

    assert_instance_of ItemRepository, item_repository
  end

  def test_item_repo_has_items
    item_repository = ItemRepository.new('./data/items.rb')

    
  end
end

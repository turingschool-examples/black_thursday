require_relative 'test_helper'
require_relative '../lib/item_repository.rb'

class ItemRepositoryTest < Minitest::Test
  def test_it_exists
    item_repository = ItemRepository.new
    assert_instance_of ItemRepository, item_repository
  end
end

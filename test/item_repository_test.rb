require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item_repository'

# Test for Item Repository class
class ItemRepositoryTest < Minitest::Test
  def setup
    @item_repository = ItemRepository.new('../data/items.csv')
  end

  def test_item_repository_exists
    assert_instance_of ItemRepository, @item_repository
  end

  def test_item_respository_has_data_file_attribute
    assert_equal '../data/items.csv', @item_repository.data_file
  end
end

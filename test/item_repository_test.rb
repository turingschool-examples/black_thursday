require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository.rb'
require 'pry'

class ItemRepositoryTest < Minitest::Test

  def test_item_repository_exists
    item_repo = ItemRepository.new
    assert_instance_of ItemRepository, item_repo
  end

  def test_item_repository_has_an_empty_items_array
    item_repo = ItemRepository.new
    assert_equal item_repo.items, []
  end

  def test_item_repository_can_be_populated
    item_repo = ItemRepository,new

end

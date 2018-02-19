require_relative 'test_helper'
require_relative '../lib/item_repository'
require 'bigdecimal'
require 'pry'

class ItemRepositoryTest < Minitest::Test
  def test_it_exists
    item_repository = ItemRepository.new('./test/fixtures/items.csv')

    assert_instance_of ItemRepository, item_repository
  end

  def test_item_repo_has_items
    item_repository = ItemRepository.new('./test/fixtures/items.csv')

    assert_equal 9, item_repository.all.count
    assert_instance_of Array, item_repository.all
    assert(item_repository.all.all?) { |item| item.is_a?(Item) }
  end

  def test_find_items
    item_repository = ItemRepository.new('./test/fixtures/items.csv')

    assert_nil item_repository.find_items('./test/fixtures/items.csv')
  end


end

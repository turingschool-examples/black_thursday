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

  def test_find_by_id
    item_repository = ItemRepository.new('./test/fixtures/items.csv')

    assert_nil item_repository.find_by_id(12345)
    assert_instance_of Item, item_repository.find_by_id(1)
  end

  def test_find_by_name
    item_repository = ItemRepository.new('./test/fixtures/items.csv')
    name = 'Glitter scrabble frames'
    name_case_insensitive = 'gLiTTeR ScRabBle FrAmEs'

    assert_nil item_repository.find_by_name('sjadfhal')
    assert_instance_of Item, item_repository.find_by_name(name)
    assert_instance_of Item, item_repository.find_by_name(name_case_insensitive)
  end

  def test_find_all_with_description
    item_repo = ItemRepository.new('./test/fixtures/items.csv')
    string = 'Any colour glitter'

    assert_equal [], item_repo.find_all_with_description('lajsfh')
    assert_instance_of Item, item_repo.find_all_with_description(string)[0]
    assert_equal 9, item_repo.find_all_with_description('a').count
  end

  def test_find_all_by_price
    item_repo = ItemRepository.new('./test/fixtures/items.csv')

    assert_equal [], item_repo.find_all_by_price(1000.00)
    assert_instance_of Item, item_repo.find_all_by_price(1200)[0]
  end
end

require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/repository'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def test_it_finds_all_items
    item_repository = ItemRepository.new('test/fixtures/items_sample.csv')

    assert_equal Array, item_repository.all.class
    refute_empty item_repository.all
  end

  def test_it_finds_items_by_id
    item_repository = ItemRepository.new('test/fixtures/items_sample.csv')

    assert_equal Item , item_repository.find_by_id(263395237).class
  end

  def test_it_can_find_an_item_by_name
    item_repository = ItemRepository.new('test/fixtures/items_sample.csv')

    assert_equal Item , item_repository.find_by_name("510+ RealPush Icon Set").class
  end


  def test_it_can_find_all_with_discription
    item_repository = ItemRepository.new('test/fixtures/items_sample.csv')

    assert_equal Array , item_repository.find_all_with_description("Disney glitter frames").class
  end

end

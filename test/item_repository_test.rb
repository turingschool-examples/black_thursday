require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'
require './lib/file_loader'
require './test/test_helper'
require 'pry'


class ItemRepositoryTest < MiniTest::Test
  include FileLoader

  def setup
    @irepo = ItemRepository.new(load_file('./data/items.csv'))
  end

  def test_existence
    # skip
    assert_instance_of ItemRepository, @irepo
  end

  def test_it_can_return_all_items
    # skip
    assert_equal 1367, @irepo.all.count
    assert_instance_of Item, @irepo.all[20]
    assert_instance_of Item, @irepo.all[99]
    assert_instance_of Item, @irepo.all[1366]
  end

  def test_test_it_can_find_item_by_id
    # skip
    item = @irepo.find_by_id(263395237)
    assert_equal '510+ RealPush Icon Set', item.name
    assert_equal 263395237, item.id
    assert_equal 12334141, item.merchant_id
    assert_equal Time.parse('2016-01-11 09:34:06 UTC'), item.created_at
  end

  def test_test_it_can_find_item_by_name
    #skip
    search_1 = @irepo.find_by_name("Glitter scrabble frames")
    item_1 = @irepo.find_by_id(263395617)

    assert_equal item_1, search_1

    search_2 = @irepo.find_by_name('Wooden pen and stand')
    item_2 = @irepo.find_by_id(263397843)

    assert_equal item_2, search_2
  end

  def test_find_by_description
    # skip
    assert_equal @irepo.repository[1], @irepo.find_all_with_description("Glitter scrabble frames \n\nAny colour glitter \nAny wording\n\nAvailable colour scrabble tiles\nPink\n
      Blue\nBlack\nWooden")
  end
end

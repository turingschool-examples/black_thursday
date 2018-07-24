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
    assert_instance_of ItemRepository, @irepo
  end

  def test_it_can_return_all_items
    assert_equal 1367, @irepo.all.count
    assert_instance_of Item, @irepo.repository[20]
    assert_instance_of Item, @irepo.repository[99]
  end

  def test_test_it_can_find_item_by_id
    assert_equal @irepo.repository[0], @irepo.find_by_id("263395237")
  end

  def test_test_it_can_find_item_by_name
     assert_equal @irepo.repository[1], @irepo.find_by_name("Glitter scrabble frames")
     assert_equal @irepo.repository[100], @irepo.find_by_name("Adidas Penarol Fußballschuh")
  end

  def test_find_by_description
    binding.pry
    assert_equal @irepo.repository[1], @irepo.find_all_with_description("Glitter scrabble frames \n\nAny colour glitter \nAny wording\n\nAvailable colour scrabble tiles\nPink\n
      Blue\nBlack\nWooden")
  end
end

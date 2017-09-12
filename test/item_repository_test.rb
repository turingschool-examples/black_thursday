require_relative 'test_helper'
require './lib/item_repository'
require './lib/item'
require 'csv'

require 'pry'

class ItemRepositoryTest < Minitest::Test

  def setup
    csv_file_name = './data/items.csv'
    @repository = ItemRepository.new(csv_file_name)
  end


  def test_it_exists
    csv_file_name = './data/items.csv'
    assert_instance_of ItemRepository, ItemRepository.new(csv_file_name)
  end

  def test_it_creates_item_objects_for_each_row
    assert_instance_of Item, @repository.items.first
  end

  def test_all_returns_array_of_all_item_objects
    assert_equal 1367, @repository.all.count
  end

  def test_find_by_id_returns_nil_if_no_id_found
    assert_nil(@repository.find_by_id('000000'))
  end

  def test_find_by_id_returns_item_of_matching_id
    item = @repository.find_by_id('263395237')
    assert_equal '263395237', item.id
  end

  def test_find_by_name_returns_nil_if_name_not_found
    search_name = 'scf'
    assert_nil(@repository.find_by_name(search_name))
  end

  def test_find_by_name_returns_an_item_with_matching_name
    search_name = 'Glitter scrabble frames'
    item = @repository.find_by_name('Glitter scrabble frames')
    assert_equal 'Glitter scrabble frames', item.name

    item = @repository.find_by_name('glitter scrabble frames')
    assert_equal 'Glitter scrabble frames', item.name
  end

  def test_find_all_with_description
    assert_empty(@repository.find_all_with_description('asdf'))
  end

  def test_find_all_with_description_returns_all_matching_items
    refute_empty(@repository.find_all_with_description('cat'))
  end

  def test_it_returns_empty_array_if_no_matching_price_is_found
    assert_empty(@repository.find_all_by_price(-1))
  end

  def test_it_finds_all_items_with_matching_price
    first = refute_empty(@repository.find_all_by_price(13.00))
    second = refute_empty(@repository.find_all_by_price(0.13))
    third = refute_empty(@repository.find_all_by_price('0.13'))

    assert first == second
    assert second == third
  end

  def test_it_returns_empty_array_if_no_match_by_price_range
    skip
    #shouldn't it return something for zero?
    assert_empty(@repository.find_all_by_price_in_range(-1..0))
  end

  def test_it_finds_all_by_price_in_range
    refute_empty(@repository.find_all_by_price_in_range(0..10))
  end

  def test_it_finds_all_items_with_matching_merchant_id
    skip
  end





end

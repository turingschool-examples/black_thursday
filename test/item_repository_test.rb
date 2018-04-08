require_relative 'test_helper'
require './lib/item_repository'
require 'pry'

class ItemRepositoryTest < Minitest::Test
  def setup
    @ir = ItemRepository.new('./test/fixtures/items_truncated.csv')
  end

  def test_it_exists
    assert_instance_of ItemRepository, @ir
  end

  def test_it_has_items
    assert_equal 5, @ir.all.count
    assert_instance_of Array, @ir.all
    assert(@ir.all.all?) { |item| item.is_a?(Item) }
  end

  def test_find_items
    assert_nil @ir.find_by_id(777)
    assert_instance_of Item, @ir.find_by_id(1)
  end

  def test_find_by_name
    name = 'Disney scrabble frames'
    name_case_insensitive = 'disney SCRABBLE FraMeS'

    assert_nil @ir.find_by_name('beebop')
    assert_instance_of Item, @ir.find_by_name(name)
    assert_instance_of Item, @ir.find_by_name(name_case_insensitive)
  end

  def test_find_all_with_description
    description = 'Almost every social icon on the planet earth'

    assert_equal [], @ir.find_all_with_description('beebop')
    assert_instance_of Item, @ir.find_all_with_description(description)[0]
    assert_equal 5, @ir.find_all_with_description('a').count
  end

  def test_find_all_by_price
    assert_equal [], @ir.find_all_by_price(777)
    assert_instance_of Item, @ir.find_all_by_price(13.5)[0]
  end

  def test_find_all_by_price_in_range
    assert_equal [], @ir.find_all_by_price_in_range((0..1))
    assert_instance_of Item, @ir.find_all_by_price_in_range((1..15))[0]
    assert_equal 5, @ir.find_all_by_price_in_range((1..10000)).count
  end

  def test_find_all_by_merchant_id

  end

  def test_create_item_attribute

  end

  def test_update_item

  end

  def test_delete_item

  end
end

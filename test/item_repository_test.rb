require 'bigdecimal'

require './test/test_helper'
return

require './lib/item_repository'
require './lib/item'

class ItemRepositoryTest < Minitest::Test

  attr_reader :item_repo
  def setup
    @item_repo = Fixture.repo(:items)
  end

  def test_initialize_takes_a_sales_engine_and_an_array_of_record_data
    args = [Fixture.sales_engine, Fixture.data[:items]]
    assert_instance_of ItemRepository, ItemRepository.new(*args)
  end

  def test_all_returns_array_of_all_items
    assert_instance_of Array, item_repo.all
    assert item_repo.all.all?{ |item| item.is_a? Item }
  end

  def test_find_by_id_returns_item_with_that_id_if_contained
    item = item_repo.find_by_id(263407925)
    assert_instance_of Item, item
    assert_equal 263407925, item.id
  end

  def test_find_by_id_returns_nil_if_not_found
    assert_nil item_repo.find_by_id(-1)
  end

  def test_find_by_name_returns_item_with_that_name_if_contained
    item = item_repo.find_by_name('Adidas Breitner Super Fußballschuh')
    assert_instance_of Item, item
    assert_equal 'Adidas Breitner Super Fußballschuh', item.name
  end

  def test_find_by_name_is_case_insensitive
    item = item_repo.find_by_name('adIDaS BrEitneR suPer Fußballschuh')
    assert_instance_of Item, item
    assert_equal 'Adidas Breitner Super Fußballschuh', item.name
  end

  def test_find_by_name_returns_nil_if_no_match
    assert_nil item_repo.find_by_name('!@#$%^&}')
  end

  def test_find_all_with_description_returns_array_of_items_with_substring

  end

  def test_find_all_with_description_can_find_multiple_items
    other_fruits = item_repo.find_all_with_description("fruit")
    assert_equal 3, other_fruits.length
  end

  def test_find_all_with_description_is_case_insensitive
    other_fruits = item_repo.find_all_with_description("frUiT")
    assert_equal 3, other_fruits.length
  end

  def test_find_all_with_description_returns_empty_array_if_nothing_found
    assert_equal [], item_repo.find_all_with_description('!@#$%^&}')
  end

  def test_find_all_by_price_returns_array_of_items_exactly_matching
    bananas = item_repo.find_all_by_price(0.5)
    assert_instance_of Array, bananas
    assert_instance_of Item, bananas.first
  end

  def test_find_all_by_price_can_find_multiple_items
    apples_and_durians = item_repo.find_all_by_price(1)
    assert_equal 2, apples_and_durians.length
  end

  def test_find_all_by_price_returns_empty_array_if_nothing_found
    assert_equal [], item_repo.find_all_by_price(0)
  end

  def test_find_all_by_price_in_range_returns_array_of_items
    bananas = item_repo.find_all_by_price_in_range(0.4..0.6)
    assert_instance_of Array, bananas
    assert_instance_of Item, bananas.first
  end

  def test_find_all_by_price_in_range_can_find_multiple_items
    not_cherries = item_repo.find_all_by_price_in_range(0..2)
    assert_equal 3, not_cherries.length
  end

  def test_find_all_by_price_in_range_is_double_inclusive
    not_cherries = item_repo.find_all_by_price_in_range(0.5..1)
    assert_equal 3, not_cherries.length
  end

  def test_find_all_by_price_in_range_returns_empty_array_if_nothing_found
    assert_equal [], item_repo.find_all_by_price_in_range(100_001.01..100_001.02)
  end

  def test_find_all_by_merchant_id_returns_array_of_items
    apples = item_repo.find_all_by_merchant_id(1)
    assert_instance_of Array, apples
    assert_instance_of Item, apples.first
  end

  def test_find_all_by_merchant_id_can_find_multiple_items
    bananas_and_cherries = item_repo.find_all_by_merchant_id(2)
    assert_equal 2, bananas_and_cherries.length
  end

  def test_find_all_by_merchant_id_returns_empty_array_if_nothing_found
    assert_equal [], item_repo.find_all_by_merchant_id(100_000)
  end

end

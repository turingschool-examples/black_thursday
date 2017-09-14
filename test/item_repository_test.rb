require 'bigdecimal'

require './test/test_helper'

require './lib/item_repository'
require './lib/item'

class ItemRepositoryTest < Minitest::Test

  attr_reader :item_repo
  def setup
    @item_repo= ItemRepository.new(Fixture.sales_engine, Fixture.item_data)
  end

  def test_it_takes_an_array_of_items
    assert_instance_of ItemRepository, item_repo
  end

  def test_all_returns_array_of_all_items
    assert_instance_of Array, item_repo.all
    assert_instance_of Item, item_repo.all.first
  end

  def test_all_returns_a_copy
    refute_same item_repo.all, item_repo.all
  end

  def test_find_by_id_returns_item
    assert_instance_of Item, item_repo.find_by_id(1)
  end

  def test_find_by_id_returns_nil_if_not_found
    assert_nil item_repo.find_by_id(34)
  end

  def test_find_by_name_returns_item
    assert_instance_of Item, item_repo.find_by_name('Apple')
  end

  def test_find_by_name_returns_nil_if_not_found
    assert_nil item_repo.find_by_name('!@#$%^&}')
  end

  def test_find_by_name_is_case_insensitive
    assert_equal 'Banana', item_repo.find_by_name('baNanA').name
  end

  def test_find_all_with_description_returns_array_of_items_containing_substring
    durians = item_repo.find_all_with_description("thing with seeds")
    assert_instance_of Array, durians
    assert_instance_of Item, durians.first
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

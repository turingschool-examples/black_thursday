require 'bigdecimal'

require './test/test_helper'

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
    icon_matches = item_repo.find_all_with_description("icon")
    assert_equal 1, icon_matches.length
  end

  def test_find_all_with_description_can_find_multiple_items
    fitted_matches = item_repo.find_all_with_description("fitted")
    assert_equal 2, fitted_matches.length
  end

  def test_find_all_with_description_is_case_insensitive
    fitted_matches = item_repo.find_all_with_description("fItTed")
    assert_equal 2, fitted_matches.length
  end

  def test_find_all_with_description_returns_empty_array_if_nothing_found
    assert_equal [], item_repo.find_all_with_description('!@#$%^&}')
  end

  def test_find_all_by_price_returns_array_of_items_exactly_matching
    price = BigDecimal.new('9.99')
    matches = item_repo.find_all_by_price(price)
    assert_instance_of Array, matches
    assert_equal 2, matches.length
    assert_equal price, matches.first.unit_price
  end

  def test_find_all_by_price_returns_empty_array_if_nothing_found
    assert_equal [], item_repo.find_all_by_price(0)
  end

  def test_find_all_by_price_in_range_returns_array_of_items
    price_range = 10..20
    matches = item_repo.find_all_by_price_in_range(price_range)
    assert_instance_of Array, matches
    assert_equal 5, matches.length
    assert price_range.include? matches.first.unit_price
  end

  def test_find_all_by_price_in_range_returns_empty_array_if_nothing_found
    assert_equal [], item_repo.find_all_by_price_in_range(-2..-1)
  end

  def test_find_all_by_merchant_id_returns_array_of_items
    merchant_id = 12334105
    matches = item_repo.find_all_by_merchant_id(merchant_id)
    assert_instance_of Array, matches
    assert_equal 3, matches.length
    assert_equal merchant_id, matches.first.merchant_id
  end

  def test_find_all_by_merchant_id_returns_empty_array_if_nothing_found
    assert_equal [], item_repo.find_all_by_merchant_id(-1)
  end

end

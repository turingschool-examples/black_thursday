require_relative 'test_helper'
require_relative '../lib/find_functions'
require_relative '../lib/item_repository'

class FindFunctionsTest < Minitest::Test
  include FindFunctions
  attr_reader :all

  def setup
   @all = ItemRepository.new("./data/test_items.csv").all
  end

  def test_find_functions_exists_and_is_a_module
    assert Module, FindFunctions.class
  end

  def test_it_returns_an_object_that_meets_the_criteria
    input = "510+ RealPush Icon Set"
    assert_equal Item, find_by(:name, input).class
  end

  def test_it_returns_nil_if_the_element_is_not_found
    input = "BetterCallSaul"
    assert_equal nil, find_by(:name, input)
  end

  def test_find_all_prices_returns_item_object_for_unique_price
    assert find_all_prices(119.00).one?{|item| item.class == Item}
  end

  def test_find_all_prices_returns_one_object_for_a_unique_price
    assert find_all_prices(119.00).count == 1
  end

  def test_find_all_prices_returns_item_objects_for_common_price
    assert find_all_prices(12.00).all?{|item| item.class == Item}
  end

  def test_find_all_prices_returns_more_than_one_object_for_common_price
    assert find_all_prices(12.00).count > 1
  end

  def test_find_all_prices_returns_an_empty_array_if_no_prices_found
    assert_equal [], find_all_prices(18.75)
  end

  def test_find_all_merch_ids_returns_item_objects
    assert find_all_merch_ids(12334185).all?{|item| item.class == Item}
  end

  def test_find_all_merch_ids_returns_more_than_one_object_for_common_merch_id
    assert find_all_merch_ids(12334185).count > 1
  end

  def test_find_all_merch_ids_returns_item_object_for_unique_price
    assert find_all_merch_ids(12334141).one?{|item| item.class == Item}
  end

  def test_find_all_merch_ids_returns_one_object_for_a_unique_price
    assert_equal 1, find_all_merch_ids(12334141).count
  end

  def test_find_all_merch_ids_returns_an_empty_array_if_no_merch_ids_found
    assert_equal [], find_all_merch_ids(1)
  end

  def test_finds_all_strings_returns_matching_item_object_for_description
    input = "handwoven pillow"
    assert_equal 1, find_all_strings(:description, input).count
  end

end

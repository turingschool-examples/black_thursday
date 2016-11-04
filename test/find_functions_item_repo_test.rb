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

  def test_find_by_filters_name_method
    input = "510+ RealPush Icon Set"
    assert_equal Item, find_by(:name, input).class
    assert_equal find_by(:name, input).name, input
  end

  def test_find_name_returns_item_that_meets_the_criteria
    input = "510+ RealPush Icon Set"
    assert_equal Item, find_name(input).class
    assert_equal find_name(input).name, input
  end

  def test_find_by_filters_id_method
    input = 263395237
    assert_equal Item, find_by(:id, input).class
    assert_equal find_by(:id, input).id, input
  end

  def test_find_id_returns_item_that_meets_criteria
    input = 263395237
    assert_equal Item, find_id(input).class
    assert_equal find_id(input).id, input
  end

  def test_it_returns_nil_if_the_element_is_not_found
    input = "BetterCallSaul"
    assert_equal nil, find_by(:name, input)
  end

  def test_find_all_filters_unit_price_method
    input = 12.00
    assert_equal Array, find_all(:unit_price, input).class
    result = find_all(:unit_price, input) 
    assert result.all?{|item| item.class == Item}
    assert result.all?{|item| item.unit_price == input}
  end

  def test_find_all_equivalent_returns_item_object_for_unique_price
    assert find_all_equivalent(:unit_price, 119.00).one?{|item| item.class == Item}
    assert find_all_equivalent(:unit_price, 119.00).count == 1
  end

  def test_find_all_equivalent_returns_item_objects_for_common_price
    assert find_all_equivalent(:unit_price, 12.00).all?{|item| item.class == Item}
    assert find_all_equivalent(:unit_price, 12.00).count > 1
  end

  def test_find_all_equivalent_returns_an_empty_array_if_no_equivalent_found
    assert_equal [], find_all_equivalent(:unit_price, 18.75)
  end

  def test_find_all_filters_merchant_id_method
    input = 12334185
    assert_equal Array, find_all(:merchant_id, input).class
    result = find_all(:merchant_id, input) 
    assert result.all?{|item| item.class == Item}
    assert result.all?{|item| item.merchant_id == input}
  end

  def test_find_all_equivalent_returns_item_objects_for_merch_id
    assert find_all_equivalent(:merchant_id, 12334185).all?{|item| item.class == Item}
  end

  def test_find_all_equivalent_returns_more_than_one_object_for_common_merch_id
    assert find_all_equivalent(:merchant_id, 12334185).count > 1
  end

  def test_find_all_equivalent_returns_item_object_for_unique_price
    assert find_all_equivalent(:merchant_id, 12334141).one?{|item| item.class == Item}
  end

  def test_find_all_equivalent_returns_one_object_for_a_unique_price
    assert_equal 1, find_all_equivalent(:merchant_id, 12334141).count
  end

  def test_find_all_equivalent_returns_an_empty_array_if_no_equivalent_found
    assert_equal [], find_all_equivalent(:merchant_id, 1)
  end

  def test_find_all_filters_description_method
    input = "handwoven pillow"
    assert_equal Array, find_all(:description, input).class
    result = find_all(:description, input) 
    assert result.all?{|item| item.class == Item}
    assert result.all?{|item| item.description.downcase.include?(input.downcase)}
  end

  def test_finds_all_strings_returns_matching_item_object_for_description
    input = "handwoven pillow"
    assert_equal 1, find_all_strings(:description, input).count
  end

  def test_equivalence_needed_evaluates_method_name
    assert equivalence_needed?(:unit_price)
  end

end

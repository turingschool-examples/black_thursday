require_relative 'test_helper'
require './lib/find_functions'
require './lib/item_repository'
require './lib/merchant_repository'

class FindFunctionsTest < Minitest::Test
  include FindFunctions
  attr_reader :collection, 
              :collection2
  
  def setup
   @collection = ItemRepository.new("./data/test_items.csv").item_objects
   @collection2 = MerchantRepository.new("./data/test_merchants.csv").merchant_objects
  end

  def test_find_functions_exists_and_is_a_module
    assert Module, FindFunctions.class
  end

  def test_it_returns_an_object_that_meets_the_criteria
    input = "510+ RealPush Icon Set"
    assert_equal Item, find_by(collection, :name, input).class
  end

  def test_it_returns_nil_if_the_element_is_not_found
    input = "BetterCallSaul"
    assert_equal nil, find_by(collection, :name, input)
  end

  def test_find_all_prices_returns_item_object_for_unique_price
    assert find_all_prices(collection, 119.00).one?{|item| item.class == Item}
  end

  def test_find_all_prices_returns_one_object_for_a_unique_price
    assert find_all_prices(collection, 119.00).count == 1
  end

  def test_find_all_prices_returns_item_objects_for_common_price
    assert find_all_prices(collection, 12.00).all?{|item| item.class == Item}
  end

  def test_find_all_prices_returns_more_than_one_object_for_common_price
    assert find_all_prices(collection, 12.00).count > 1
  end

  def test_find_all_prices_returns_an_empty_array_if_no_prices_found
    assert_equal [], find_all_prices(collection, 18.75)
  end

  def test_find_all_merch_ids_returns_item_objects
    assert find_all_merch_ids(collection, 12334185).all?{|item| item.class == Item}
  end

  def test_find_all_merch_ids_returns_more_than_one_object_for_common_merch_id
    assert find_all_merch_ids(collection, 12334185).count > 1
  end
  
  def test_find_all_merch_ids_returns_item_object_for_unique_price
    assert find_all_merch_ids(collection, 12334141).one?{|item| item.class == Item}
  end

  def test_find_all_merch_ids_returns_one_object_for_a_unique_price
    assert_equal 1, find_all_merch_ids(collection, 12334141).count
  end

  def test_find_all_merch_ids_returns_an_empty_array_if_no_merch_ids_found
    assert_equal [], find_all_merch_ids(collection, 1)
  end
  
  def test_finds_all_strings_returns_matching_item_object_for_description
    input = "handwoven pillow"
    assert_equal 1, find_all_strings(collection, :description, input).count
  end
  
  def test_finds_all_strings_returns_matching_merchant_object_for_name
    input = "MiniatureBikez"
    assert_equal 1, find_all_strings(collection2, :name, input).count
  end
  
  def test_finds_all_strings_returns_matching_merchant_object_for_name_fragment
    input = "mad"
    assert_equal 5, find_all_strings(collection2, :name, input).count
  end

  def test_find_all_strings_returns_an_empty_array_if_none_are_found
    input = "schutte"
    assert_equal [], find_all_strings(collection, :description, input)
  end
  
  def test_finds_all_strings_returns_matching_merchant_object_for_name
    input = "MiniatureBikez"
    assert_equal 1, find_all_strings(collection2, :name, input).count
  end
  
  def test_finds_all_strings_returns_matching_merchant_object_for_name_fragment
    input = "mad"
    assert_equal 5, find_all_strings(collection2, :name, input).count
  end

  def test_find_all_returns_item_objects_for_common_price_if_method_unit_price
    prices = find_all(collection, :unit_price, 12.00)
    assert prices.all?{|item| item.class == Item}
  end

  def test_find_all_returns_item_objects_for_common_merch_id_if_method_merchant_id
    merchant_ids = find_all(collection, :merchant_id, 12334141)
    assert merchant_ids.all?{|item| item.class == Item}
  end

  def test_find_all_returns_merchant_objects_for_common_name_if_method_name
    names = find_all(collection2, :name, "MiniatureBikez")
    assert names.all?{|item| item.class == Merchant}
  end

  def test_find_all_returns_item_objects_for_common_name_if_method_name
    descriptions = find_all(collection, :description, "mad")
    assert descriptions.all?{|item| item.class == Item}
  end
  
end

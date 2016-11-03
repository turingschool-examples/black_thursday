require_relative 'test_helper'
require_relative '../lib/find_functions'
require_relative '../lib/merchant_repository'

class FindFunctionsTest < Minitest::Test
  include FindFunctions
  attr_reader :all

  def setup
   @all = MerchantRepository.new("./data/test_merchants.csv").all
  end

  def test_find_functions_exists_and_is_a_module
    assert Module, FindFunctions.class
  end

  def test_find_by_filters_name_method
    input = "Candisart"
    assert_equal Merchant, find_by(:name, input).class
    assert_equal find_by(:name, input).name, input
  end

  def test_find_name_returns_merchant_that_meets_criteria
    input = "Candisart"
    assert_equal Merchant, find_name(input).class
    assert_equal find_name(input).name, input
  end

  def test_find_by_filters_id_method
    input = 12334112
    assert_equal Merchant, find_by(:id, input).class
    assert_equal find_by(:id, input).id, input
  end

  def test_find_id_returns_merchant_that_meets_criteria
    input = 12334112
    assert_equal Merchant, find_id(input).class
    assert_equal find_id(input).id, input
  end

  def test_finds_all_strings_returns_matching_merchant_object_for_name
    input = "MiniatureBikez"
    assert_equal 1, find_all_strings(:name, input).count
  end

  def test_finds_all_strings_returns_matching_merchant_object_for_name_fragment
    input = "mad"
    assert_equal 6, find_all_strings(:name, input).count
  end

  def test_finds_all_strings_returns_matching_object_case_insensitive
    input = "mAd"
    assert_equal 6, find_all_strings(:name, input).count
  end

  def test_finds_all_strings_returns_matching_merchant_object_for_upcase_search
    input = "JEJUM"
    assert_equal 1, find_all_strings(:name, input).count
  end

  def test_finds_all_strings_returns_matching_merchant_object_for_name
    input = "MiniatureBikez"
    assert_equal 1, find_all_strings(:name, input).count
  end

  def test_find_all_returns_merchant_objects_for_common_name_if_method_name
    names = find_all(:name, "MiniatureBikez")
    assert names.all?{|item| item.class == Merchant}
  end

end

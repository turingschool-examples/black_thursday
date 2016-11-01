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

  def test_finds_all_strings_returns_matching_merchant_object_for_name
    input = "MiniatureBikez"
    assert_equal 1, find_all_strings(:name, input).count
  end

  def test_finds_all_strings_returns_matching_merchant_object_for_name_fragment
    input = "mad"
    assert_equal 5, find_all_strings(:name, input).count
  end

  def test_finds_all_strings_returns_matching_merchant_object_for_name
    input = "MiniatureBikez"
    assert_equal 1, find_all_strings(:name, input).count
  end

  def test_finds_all_strings_returns_matching_merchant_object_for_name_fragment
    input = "mad"
    assert_equal 5, find_all_strings(:name, input).count
  end

  def test_find_all_returns_merchant_objects_for_common_name_if_method_name
    names = find_all(:name, "MiniatureBikez")
    assert names.all?{|item| item.class == Merchant}
  end

end

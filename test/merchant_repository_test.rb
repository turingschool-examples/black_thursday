require 'test_helper'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def test_it_exists
    # se = SalesEngine.from_csv({
    #   :items     => "./data/items.csv",
    #   :merchants => "./data/merchants.csv",})
    #
    # mr = se.merchants
    # merchant = mr.find_by_name("CJsDecor")
    #   # => <Merchant>
  end

  def test_it_returns_an_array_of_all_merchant_instances
    # method #all
    # returns an array of all known Merchant instances
  end

  def test_it_can_find_a_merchant_by_id
    # method #find_by_id
    # returns either nil or an instance of Merchant with a matching ID
  end

  def test_it_returns_nil_if_the_merchant_doesn_not_exist
    # method #find_by_id
    # returns either nil or an instance of Merchant with a matching ID
  end

  def test_it_can_find_a_merchant_by_name
    # method #find_by_name
    # returns either nil or an instance of Merchant having done a case insensitive search
  end

  def test_the_merchant_by_name_search_is_case_insensitive
    # method #find_by_name
    # returns either nil or an instance of Merchant having done a case insensitive search
  end

  def find_by_name
    # method #find_by_name
    # returns either nil or an instance of Merchant having done a case insensitive search
  end

  def find_all_by_name
    # returns either [] or one or more matches which contain the supplied name fragment, case insensitive
  end
end

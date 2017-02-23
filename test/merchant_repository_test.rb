require './test/test_helper'
require './lib/merchant_repository'
require './lib/sales_engine'
require './lib/merchant'

class MerchantRepositoryTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv"})

    @mr = @se.merchants
  end

  def test_it_can_load_csv
    # skip
    assert_instance_of CSV, @mr.csv_loader("./data/merchants.csv")
  end


  def test_it_can_create_instance_of_merchant
    # skip
    assert_instance_of Merchant, @mr.all.first
  end

  def test_it_can_return_array_of_all_known_merchant_instances
    assert_instance_of Array, @mr.all
  end

  def test_it_can_find_merchant_by_name
    merchant = @mr.find_by_name("CJsDecor")
    assert_instance_of Merchant, merchant
  end

  def test_it_can_find_merchant_by_id
    merchant = @mr.find_by_id(12334105)
    assert_instance_of Merchant, merchant
  end
end

-----------------------------------

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

  def test_it_returns_nil_if_the_merchant_does_not_exist
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

  def test_it_returns_nil_if_the_merchant_does_not_exist
    # method #find_by_name
    # returns either nil or an instance of Merchant having done a case insensitive search
  end

  def test_it_can_find_all_merchants_matching_name_fragment
    # method #find_all_by_name
    # returns either [] or one or more matches which contain the supplied name fragment, case insensitive
  end

  def test_it_can_return_an_empty_array_if_no_matches_are_found
    # method #find_all_by_name
    # returns either [] or one or more matches which contain the supplied name fragment, case insensitive
  end
end

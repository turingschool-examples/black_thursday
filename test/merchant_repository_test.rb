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

  def test_it_returns_nil_if_the_merchant_by_id_does_not_exist
    merchant = @mr.find_by_id(904)
    assert_nil nil, merchant
  end

  def test_it_can_find_merchant_by_name
    merchant = @mr.find_by_name("CJsDecor")
    assert_instance_of Merchant, merchant
  end

  def test_it_can_find_merchant_by_id
    merchant = @mr.find_by_id(12334105)
    assert_instance_of Merchant, merchant
  end

  def test_it_returns_nil_if_the_merchant_by_name_does_not_exist
    merchant = @mr.find_by_name("vfjsbvsfv")
    assert_nil nil, merchant
  end

  def test_the_merchant_by_name_search_is_case_insensitive
    merchant = @mr.find_by_name("cjsdecor")
    assert_equal "CJsDecor", merchant.name
  end

  def test_it_can_find_all_merchants_matching_name_fragment
    merchant = @mr.find_all_by_name("end")
    assert_equal 7, merchant.count
  end

  def test_it_can_return_an_empty_array_if_no_matches_are_found
    merchant = @mr.find_all_by_name("vfjsbvsfv")
    assert_equal [], merchant
  end
end

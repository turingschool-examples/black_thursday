require './test/test_helper'
require './lib/merchant_repository'
require './lib/sales_engine'
require './lib/merchant'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :items     => "./data/items.csv",
      :customers => "./data/customers.csv",
      :invoices  => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv"
      })

    @mr = @se.merchants
  end

  def test_it_can_load_csv
    assert_instance_of CSV, @mr.csv
  end

  def test_it_can_create_instance_of_merchant
    assert_instance_of Merchant, @mr.all.first
  end

  def test_all_returns_an_array
    assert_instance_of Array, @mr.all
  end

  def test_all_contains_proper_number_of_merchants
    assert_equal 10, @mr.all.count
    assert_equal Merchant, @mr.all.first.class
  end

  def test_it_returns_nil_if_the_merchant_by_id_does_not_exist
    merchant = @mr.find_by_id(904)
    assert_nil nil, merchant
  end

  def test_it_can_find_merchant_by_name
    merchant = @mr.find_by_name("BowlsByChris")
    assert_instance_of Merchant, merchant
  end

  def test_the_merchant_by_name_search_is_case_insensitive
    merchant = @mr.find_by_name("bowlsbychriS")
    assert_equal "BowlsByChris", merchant.name
  end

  def test_it_can_find_merchant_by_id
    merchant = @mr.find_by_id(12334105)
    assert_instance_of Merchant, merchant
  end

  def test_it_returns_nil_if_the_merchant_by_name_does_not_exist
    merchant = @mr.find_by_name("vfjsbvsfv")
    assert_nil merchant, 'merchant was supposed to return nil!'
  end

  def test_it_can_find_all_merchants_matching_name_fragment
    merchant = @mr.find_all_by_name("in")
    assert_equal 2, merchant.count
  end

  def test_it_can_return_an_empty_array_if_no_matches_are_found
    merchant = @mr.find_all_by_name("vfjsbvsfv")
    assert_equal [], merchant
  end
end

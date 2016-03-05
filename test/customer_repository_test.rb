require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'

class CustomerRepositoryTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv({
      :merchants => './fixtures/merchants_fixtures.csv',
      :items     => './fixtures/items_fixtures.csv',
      :invoices  => './fixtures/invoices_fixtures.csv',
      :customers => './fixtures/customers_fixtures.csv'
      })
    @cr = se.customers
# 1,Joey,Ondricka,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
  end

  def test_find_by_id_returns_custy_with_id
    assert_equal "Joey", @cr.find_by_id(1).first_name
  end

  def test_find_by_id_returns_nil_if_id_does_not_exist
    assert_equal nil, @cr.find_by_id(34)
  end

  def test_find_all_by_first_name_finds_name_containing_fragment_and_is_case_insensetive
    assert_equal "Joey", @cr.find_all_by_first_name("jo")[0].first_name
  end

  def test_find_all_by__first_name_returns_empty_array_if_none_match
    assert_equal [], @cr.find_all_by_first_name("jdhjhd")
  end

  def test_find_all_by_last_name_finds_name_containing_fragment_and_is_case_insensetive
    assert_equal "Ondricka", @cr.find_all_by_last_name("ndric")[0].last_name
  end

  def test_find_all_by_last_name_returns_empty_array_if_none_match
    assert_equal [], @cr.find_all_by_last_name("hde")
  end
end

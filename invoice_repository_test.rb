require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require 'time'
require 'pry'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'
class InvoiceRepositoryTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv({
            :merchants => './fixtures/merchants_fixtures.csv',
            :items     => './fixtures/items_fixtures.csv',
            :invoices   => './fixtures/invoices_fixtures.csv'
            })
    @ir = se.invoices
  end

  def test_all_returns_array_of_all_invoices
    all = @ir.all
    assert_equal "", all[0].name
    assert_equal "", all[1].name
    assert_equal 5, all.count
  end

  def test_find_by_id_returns_first_invoice_with_matching_id
    assert_equal "", @ir.find_by_id(id).name
  end

  def test_find_by_id_returns_nil_if_id_does_not_exist
    assert_equal "", @ir.find_by_id(id).name
  end

  def test_find_all_by_customer_id_returns_array_of_invoices_with_matching_custy_ids
    all = @ir.find_all_by_customer_id(23432423)
    assert_equal "", all[0].name
    assert_equal "", all[1].name
    assert_equal "", all[2].name
    assert_equal 5, all.count
  end

  def test_find_all_by_customer_id_returns_empty_array_if_id_doesnt_match
    assert_equal [], @ir.find_all_by_customer_id(12344543)
  end

  def test_find_all_by_merchant_id_returns_array_of_items_with_merch_id
    all = @ir.find_all_by_merchant_id(324324324)
    assert_equal "", all[0].name
    assert_equal "", all[0].name
    assert_equal 5, all.count
  end

  def test_find_all_by_merch_id_returns_empty_array_if_there_are_no_matches
    assert_equal [], @ir.find_all_by_merchant_id
  end

  def test_find_all_by_status_returns_array_of_items_with_matching_status
    all = @ir.find_all_by_status(:pending)
    assert_equal :pending, all[0].status
    assert_equal :pending, all[1].status
    assert_equal :pending, all[2].status
  end

  def test_find_all_by_status_returns_empty_array_if_no_matching_status
    assert_equal nil, @ir.find_all_by_status(:lozgag)
  end

end

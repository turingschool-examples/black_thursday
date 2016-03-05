require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require 'time'
require 'pry'
require_relative '../lib/transaction_repository'
require_relative '../lib/sales_engine'

class TransactionRepositoryTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv({
            :merchants     => './fixtures/merchants_fixtures.csv',
            :items         => './fixtures/items_fixtures.csv',
            :invoices      => './fixtures/invoices_fixtures.csv',
            :invoice_items => './fixtures/invoice_items_fixtures.csv',
            :transactions  => './fixtures/transactions_fixtures.csv'
            })
    @tr = se.transactions
  end

  def test_all_returns_array_of_all_transactions
    all = @tr.all
    assert_equal 1, all[0].id
    assert_equal 2, all[1].id
    assert_equal 3, all[2].id
    assert_equal 12, all.count
  end

  def test_find_by_id_returns_ftrst_transaction_with_matching_id
    assert_equal 1, @tr.find_by_id(1).id
  end

  def test_find_by_id_returns_nil_if_id_does_not_exist
    assert_equal nil, @tr.find_by_id(567)
  end

  def test_find_all_by_invoice_id_returns_array_of_transactions_with_matching_invoice_ids
    all = @tr.find_all_by_invoice_id(5)
    assert_equal 4, all[0].id
    assert_equal 7, all[1].id
    assert_equal 9, all[2].id
    assert_equal 3, all.count
  end

  def test_find_all_by_invoice_id_returns_empty_array_if_id_doesnt_match
    assert_equal [], @tr.find_all_by_invoice_id(143)
  end

  def test_find_all_by_credit_card_number_returns_array_of_transactions_with_matching_id
    all = @tr.find_all_by_credit_card_number("4068631943231473")
    assert_equal 1, all[0].id
    assert_equal 3, all.count
  end

  def test_find_all_by_credit_card_number_returns_empty_array_if_there_are_no_matches
    assert_equal [], @tr.find_all_by_credit_card_number("4068631943")
  end
  def test_find_all_by_result_returns_array_of_transactions_with_matching_status_success
    all = @tr.find_all_by_result("success")
    assert_equal 1, all[0].id
    assert_equal 2, all[1].id
    assert_equal 3, all[2].id
    assert_equal 4, all[3].id
    assert_equal 10, all.count
  end

  def test_find_all_by_result_returns_array_of_transactions_with_matching_status_failed
    all = @tr.find_all_by_result("failed")
    assert_equal 5, all[0].id
    assert_equal 9, all[1].id
    assert_equal 2, all.count
  end
  def test_find_all_by_result_returns_empty_array_if_there_are_no_matches
    assert_equal [], @tr.find_all_by_result("question")
  end
end

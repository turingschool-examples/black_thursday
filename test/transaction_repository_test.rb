require './test/test_helper'
require './lib/sales_engine'
require './lib/transaction_repository'
require './lib/transaction'

class TransactionRepositoryTest < Minitest::Test

def setup
    @se = SalesEngine.from_csv({
      # :merchants => "./data/merchants.csv",
      # :items     => "./data/items.csv",
      # :customers => "./data/customers.csv",
      # :invoices  => "./data/invoices.csv",
      # :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv"
      })

    @tr = @se.transactions
  end

  def test_it_can_load_csv
    assert_instance_of CSV, @tr.csv
  end

  def test_it_can_create_instance_of_transaction
    assert_instance_of Transaction, @tr.all.first
  end

  def test_all_returns_an_array
    assert_instance_of Array, @tr.all
  end

  def test_it_can_find_a_transaction_by_id
    transaction = @tr.find_by_id(4944)

    assert_instance_of Transaction, transaction
  end

  def test_it_returns_nil_if_the_transaction_does_not_exist
    transaction = @tr.find_by_id(07417000)

    assert_nil transaction, 'non-existent transaction was supposed to return nil!'
  end

  def test_it_can_find_all_items_matching_invoice_id_in_transactions
    transaction = @tr.find_all_by_invoice_id(175)

    assert_instance_of Transaction, transaction.first
    assert_instance_of Array, transaction
    assert_equal 4, transaction.count
  end

  def test_it_can_return_an_empty_array_if_no_matches_are_found
    transaction = @tr.find_all_by_invoice_id(99991094725)

    assert_equal [], transaction
  end

  def test_it_can_find_all_items_matching_credit_card_number
    transaction = @tr.find_all_by_credit_card_number(4825072724408233)

    assert_instance_of Transaction, transaction.first
    assert_instance_of Array, transaction
  end

  def test_it_can_return_an_empty_array_if_no_matches_are_found
    transaction = @tr.find_all_by_credit_card_number(9090765374528603)

    assert_equal [], transaction
  end

  def test_it_can_find_all_transactions_matching_result
    transaction = @tr.find_all_by_result("success")
    assert_equal 109, transaction.count
    assert_instance_of Array, @tr.find_all_by_result("success")
  end

  def test_it_can_return_an_empty_array_if_no_matches_are_found
    transaction = @tr.find_all_by_result("canceled")
    assert_equal [], transaction
  end
end

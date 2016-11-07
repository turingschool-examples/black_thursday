require_relative './test_helper'
require_relative '../lib/transaction_repo'

class TransactionRepoTest < Minitest::Test
  def test_transaction_repo_class_exists
    assert_instance_of TransactionRepo, TransactionRepo.new('./data/transactions.csv')
  end

  def test_transaction_repo_can_populate_with_transaction_objects_and_attributes
    tr = TransactionRepo.new('./data/transactions.csv')
    assert_instance_of Transaction, tr.all.first
    assert_equal 1, tr.all.first.id
    assert_equal 2179, tr.all.first.invoice_id
    assert_equal 4068631943231473, tr.all.first.credit_card_number
    assert_equal "0217", tr.all.first.credit_card_expiration_date
    assert_equal "success", tr.all.first.result
    assert_instance_of Time, tr.all.first.created_at
    assert_instance_of Time, tr.all.first.updated_at
  end

  def test_transaction_repo_can_find_all_transactions
    tr = TransactionRepo.new('./data/transactions.csv')
    assert_instance_of Transaction, tr.all.first
    assert_equal 4985, tr.all.count
    assert_instance_of Transaction, tr.all.last
  end

  def test_transaction_repo_can_find_by_id
    tr = TransactionRepo.new('./data/transactions.csv').find_by_id(1)
    assert_equal 1, tr.id
  end

  def test_transaction_repo_returns_nil_if_invoice_id_does_not_exist
    tr = TransactionRepo.new('./data/transactions.csv').find_by_id(2132131)
    assert_equal nil, tr
  end

  def test_transaction_repo_can_find_all_transactions_by_invoice_id
    tr = TransactionRepo.new('./data/transactions.csv').find_all_by_invoice_id(2179)
    assert_equal 2, tr.count
  end

  def test_transaction_repo_can_returns_empty_array_if_transactions_by_invoice_id_does_not_exist
    tr = TransactionRepo.new('./data/transactions.csv').find_all_by_invoice_id(3894739182741)
    assert_equal [], tr
  end

  def test_transaction_repo_can_find_all_by_credit_card_number
    tr = TransactionRepo.new('./data/transactions.csv').find_all_by_credit_card_number(4068631943231473)
    assert_equal 1, tr.count
  end

  def test_transaction_repo_returns_empty_array_if_credit_card_does_not_exist
    tr = TransactionRepo.new('./data/transactions.csv').find_all_by_credit_card_number(4912837498127342)
    assert_equal [], tr
  end

  def test_transaction_repo_can_find_all_by_result
    tr = TransactionRepo.new('./data/transactions.csv').find_all_by_result("success")
    assert_equal 4158, tr.count
  end

  def test_transaction_repo_returns_empty_array_if_result_does_not_exist
    tr = TransactionRepo.new('./data/transactions.csv').find_all_by_result("rejected")
    assert_equal [], tr
  end
end

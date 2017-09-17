require "./test/test_helper"
require "./lib/sales_engine"
require "./lib/transaction_repository"
require './lib/transaction'

class TransactionRepositoryTest < Minitest::Test

  attr_reader :transaction_repository

  def setup
    item_csv = "./test/test_fixtures/transactions_short.csv"
    @transaction_repository = TransactionRepository.new('fake_transaction', item_csv)
  end

  def test_transaction_repository_exists
    assert_instance_of TransactionRepository, transaction_repository
  end

  def test_all_makes_array_of_all_transactions
    assert_instance_of Array, transaction_repository.all
    assert_instance_of Transaction, transaction_repository.all[0]
  end

  def test_find_by_id_returns_nil_for_invalid_id
    assert_nil  transaction_repository.find_by_id(1234)
  end

  def test_find_by_id_returns_transaction_instance_for_id
    assert_instance_of Transaction, transaction_repository.find_by_id(1)
  end

  def test_find_all_by_invoice_id_returns_array_of_all_with_invoice_id
    assert_instance_of Array, transaction_repository.find_all_by_invoice_id(2179)
    assert_instance_of Transaction, transaction_repository.find_all_by_invoice_id(2179)[0]
  end

  def test_find_all_by_credit_card_number
    assert_instance_of Array, transaction_repository.find_all_by_credit_card_number(4068631943231473)
    assert_instance_of Transaction, transaction_repository.find_all_by_credit_card_number(4068631943231473)[0]
  end

  def test_find_all_by_result
    assert_instance_of Array, transaction_repository.find_all_by_result(:success)
    assert_instance_of Transaction, transaction_repository.find_all_by_result(:success)[0]
  end

end

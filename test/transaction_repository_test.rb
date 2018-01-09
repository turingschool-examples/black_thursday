require_relative 'test_helper'
require_relative "../lib/transaction_repository"

class TransactionRepositoryTest < Minitest::Test

  def test_it_exists
    transaction = TransactionRepository.new("./test/fixtures/transactions_sample.csv", "se")

    assert_instance_of TransactionRepository, transaction
  end

  def test_transactions_is_filled
    transaction = TransactionRepository.new("./test/fixtures/transactions_sample.csv", "se")

    assert_instance_of Transaction, transaction.transactions.first
    assert_instance_of Transaction, transaction.transactions.last
  end

  def test_it_returns_correct_id
    transaction = TransactionRepository.new("./test/fixtures/transactions_sample.csv", "se")
    found_id = transaction.find_by_id(4)

    assert_equal 4048033451067370, found_id.credit_card_number
    assert_equal 4126, found_id.invoice_id
  end

  def test_it_finds_all_by_invoice_id
    transaction = TransactionRepository.new("./test/fixtures/transactions_sample.csv", "se")
    found_id = transaction.find_all_by_invoice_id(2179)

    assert_equal 2, found_id.count
    refute_equal 1, found_id.count
  end

  def test_it_finds_all_by_card_number
    transaction = TransactionRepository.new("./test/fixtures/transactions_sample.csv", "se")
    found_id = transaction.find_all_by_credit_card_number(4068631943231473)

    assert_equal 2, found_id.count
    refute_equal 1, found_id.count
  end

  def test_it_finds_all_by_result
    transaction = TransactionRepository.new("./test/fixtures/transactions_sample.csv", "se")
    found_id = transaction.find_all_by_result("success")

    assert_equal 7, found_id.count
    refute_equal 4, found_id.count
  end

end

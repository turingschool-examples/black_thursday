require './test/test_helper'
require './lib/transaction_repository'
require './lib/transactions'

class TransactionRepositoryTest < Minitest::Test
  attr_reader :transaction_repository

  def setup
    @transaction_repository = TransactionRepository.new('./data/transactions.csv')
  end

  def test_it_exists
    assert_instance_of TransactionRepository, transaction_repository
  end

  def test_all_returns_all_transactions
    assert_equal 4985, transaction_repository.all.count
    assert_instance_of Transaction, transaction_repository.all.first
    assert_instance_of Array, transaction_repository.all
  end

  def test_it_has_parent_value
    assert_nil transaction_repository.parent
  end

  def test_find_by_id_returns_transaction_match
    expected = transaction_repository.find_by_id(2)

    assert_equal 2, expected.id
    assert_instance_of Transaction, expected
  end

  def test_find_by_id_can_return_no_transaction_match
    expected = transaction_repository.find_by_id(011011010110110)

    assert_nil expected
  end

  def test_find_all_by_invoice_id_returns_all_matches
    expected = transaction_repository.find_all_by_invoice_id(2179)

    assert_equal 2, expected.length
    assert_equal 2179, expected.first.invoice_id
    assert_instance_of Transaction, expected.first
  end

  def test_find_all_by_invoice_id_can_return_no_matches
    expected = transaction_repository.find_all_by_invoice_id(14560)

    assert_equal [], expected
    assert expected.empty?
  end

  def test_find_all_by_credit_card_number_returns_all_matches
    credit_card_number = 4848466917766329
    expected = transaction_repository.find_all_by_credit_card_number(credit_card_number)

    assert_equal 1, expected.length
    assert_instance_of Transaction, expected.first
    assert_equal credit_card_number, expected.first.credit_card_number
  end

  def test_find_all_by_credit_card_number_can_return_no_matches
    credit_card_number = 4848466917766328
    expected = transaction_repository.find_all_by_credit_card_number(credit_card_number)

    assert_equal [], expected
    assert expected.empty?
  end

  def test_find_all_by_result_returns_all_transaction_matches
    result = "success"
    expected = transaction_repository.find_all_by_result(result)

    assert_equal 4158, expected.length
    assert_instance_of Transaction, expected.first
    assert_equal result, expected.first.result
  end

  def test_find_all_by_result_takes_different_results
    result = "failed"
    expected = transaction_repository.find_all_by_result(result)

    assert_equal 827, expected.length
    assert_instance_of Transaction, expected.first
    assert_equal result, expected.first.result
  end
end

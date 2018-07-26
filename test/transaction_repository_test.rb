require_relative 'test_helper'
require_relative '../lib/transaction_repository.rb'
require 'pry'

class TransactionRepositoryTest < Minitest::Test
  def setup
    @transaction_repository = TransactionRepository.new("./data/transactions.csv")
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @transaction_repository
  end

  def test_it_can_hold_transactions
    assert_instance_of Array, @transaction_repository.transactions
  end

  def test_its_holding_transactions
    assert_instance_of Transaction, @transaction_repository.transactions[0]
    assert_instance_of Transaction, @transaction_repository.transactions[25]
  end

  def test_it_can_return_transactions_using_all
    assert_instance_of Transaction, @transaction_repository.all[5]
    assert_instance_of Transaction, @transaction_repository.all[97]
  end

  def test_it_can_find_by_id
    expected = @transaction_repository.transactions[0]
    actual = @transaction_repository.find_by_id(1)
    assert_equal expected, actual
  end

  def test_it_can_find_all_by_invoice_id
    expected = 2
    actual = @transaction_repository.find_all_by_invoice_id(2179).count
    assert_equal expected, actual
  end

  def test_it_can_find_all_by_credit_card_number
    expected = 1
    actual = @transaction_repository.find_all_by_credit_card_number(4068631943231473).count
    assert_equal expected, actual
  end

  def test_it_can_find_all_by_result
    expected = 4158
    actual = @transaction_repository.find_all_by_result("success").count
    assert_equal expected, actual
  end
end

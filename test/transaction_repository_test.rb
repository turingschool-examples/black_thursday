require_relative 'test_helper'
require './lib/transaction_repository'
require 'pry'

class TransactionRepositoryTest < Minitest::Test
  def test_it_exists
    tr = TransactionRepository.new("./data/mini_transactions.csv")
    assert_instance_of TransactionRepository, tr
  end

  def test_it_can_return_all_transaction_instances
    tr = TransactionRepository.new("./data/mini_transactions.csv")
    assert_equal 2, tr.all.count
  end

  def test_it_can_find_by_id
    tr = TransactionRepository.new("./data/mini_transactions.csv")
    assert_instance_of Transaction, tr.find_by_id(1)
  end

  def test_it_can_find_all_by_invoice_id
    tr = TransactionRepository.new("./data/mini_transactions.csv")
    assert_instance_of Array, tr.find_all_by_invoice_id(2179)
  end

  def test_it_can_find_all_by_credit_card_number
    tr = TransactionRepository.new("./data/mini_transactions.csv")
    assert_instance_of Array, tr.find_all_by_credit_card_number(4068631943231473)
  end

  def test_it_returns_empty_array_if_credit_card_number_isnt_found
    tr = TransactionRepository.new("./data/mini_transactions.csv")
    expected = []
    assert_equal expected, tr.find_all_by_credit_card_number(4068631943231480)
  end

  def test_it_can_find_all_by_result
    tr = TransactionRepository.new("./data/mini_transactions.csv")
    assert_instance_of Array, tr.find_all_by_result("success")
  end

  def test_it_returns_empty_array_if_no_results_are_found
    tr = TransactionRepository.new("./data/mini_transactions.csv")
    expected = []
    assert_equal expected, tr.find_all_by_result("failure")
  end
end

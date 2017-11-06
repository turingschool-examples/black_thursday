require_relative 'test_helper'
require_relative "../lib/transaction_repo"

class TransactionRepoTest < Minitest::Test

  def test_it_initializes
    assert_instance_of TransactionRepository, TransactionRepository.new(self, "./data/transactions.csv")
  end

  def test_it_can_create_invoice_item_instances
    transaction_repo = TransactionRepository.new(self, "./data/transactions.csv")

    assert_instance_of Transaction, transaction_repo.transactions.first
  end

  def test_it_can_reach_the_transactions_instances_through_all
    transaction_repo = TransactionRepository.new(self, "./data/transactions.csv")

    assert_instance_of Transaction, transaction_repo.all.first
  end

  def test_it_can_find_transactions_by_id
    transaction_repo = TransactionRepository.new(self, "./data/transactions.csv")
    results = transaction_repo.find_by_id(580)

    assert_equal 1504, results.invoice_id
  end

  def test_find_by_id_can_return_nil
    transaction_repo = TransactionRepository.new(self, "./data/transactions.csv")
    results = transaction_repo.find_by_id(30000)

    assert_nil results
  end

  def test_it_can_find_all_by_invoice_id
    transaction_repo = TransactionRepository.new(self, "./data/transactions.csv")
    results = transaction_repo.find_all_by_invoice_id(2880)

    assert_equal 2, results.length
    assert_instance_of Array, results
    assert_instance_of Transaction, results.first
  end

  def test_find_all_by_item_id_can_return_an_empty_array
    transaction_repo = TransactionRepository.new(self, "./data/transactions.csv")
    results = transaction_repo.find_all_by_invoice_id(000000)

    assert_equal [], results
  end

  def test_it_can_find_all_by_credit_card_number
    transaction_repo = TransactionRepository.new(self, "./data/transactions.csv")
    results = transaction_repo.find_all_by_credit_card_number(4613250127567219)

    assert_equal 1, results.length
    assert_instance_of Array, results
    assert_equal 7, results.first.id
  end

  def test_find_all_by_credit_card_number_can_return_an_empty_array
    transaction_repo = TransactionRepository.new(self, "./data/transactions.csv")
    results = transaction_repo.find_all_by_credit_card_number(000000)

    assert_equal [], results
  end

  def test_it_can_find_all_by_result
    transaction_repo = TransactionRepository.new(self, "./data/transactions.csv")
    results = transaction_repo.find_all_by_result("success")

    assert_equal 4158, results.length
    assert_instance_of Array, results
    assert_equal 1, results.first.id
  end

  def test_find_by_result_can_return_an_empty_Array
    transaction_repo = TransactionRepository.new(self, "./data/transactions.csv")
    results = transaction_repo.find_all_by_result("dunno")

    assert_equal [], results
  end

end

require './lib/transaction_repository'
require_relative 'test_helper'

class TransactionRepositoryTest < Minitest::Test

  def test_it_populates_transaction_items
    tr = TransactionRepository.new
    tr.from_csv("./data/transactions.csv")
    transaction = tr.find_by_id(6)

    assert_equal Transaction, transaction.class
  end
  def test_it_can_find_by_invoice_id
    tr = TransactionRepository.new
    tr.from_csv("./fixtures/transactions_small_list.csv")
    result = tr.find_all_by_invoice_id(46)

    assert_equal Transaction, result[0].class
    assert_equal Array, result.class
  end

  def test_it_can_find_by_credit_card_number
    tr = TransactionRepository.new
    tr.from_csv("./fixtures/transactions_small_list.csv")
    result = tr.find_all_by_credit_card_number(4271805778010747)
    assert_equal Transaction, result[0].class
    assert_equal Array, result.class
  end

  def test_it_can_find_by_transaction_result
    tr = TransactionRepository.new
    tr.from_csv("./fixtures/transactions_small_list.csv")
    result = tr.find_all_by_result("success")

    assert_equal Transaction, result[0].class
  end
end
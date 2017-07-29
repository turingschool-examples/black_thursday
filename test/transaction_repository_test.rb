require './test/test_helper'
require './lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  def test_it_exists
    tr = TransactionRepository.new('./data/transactions_short.csv', self)

    assert_instance_of TransactionRepository, tr
  end

  def test_it_initializes_with_populated_array
    tr = TransactionRepository.new('./data/transactions_short.csv', self)

    assert_equal 10, tr.transactions.count
  end

  def test_it_can_return_all_invoice_items
    tr = TransactionRepository.new('./data/transactions_short.csv', self)

    target = tr.all

    assert_equal Array, target.class
    assert_equal 10, target.count
  end

  def test_it_can_find_by_id
    tr = TransactionRepository.new('./data/transactions_short.csv', self)

    target = tr.find_by_id(1)
    target_2 = tr.find_by_id(00000000)

    assert_equal 2179, target.invoice_id
    assert_nil target_2
  end

  def test_it_can_find_all_by_invoice_id
    tr = TransactionRepository.new('./data/transactions_short.csv', self)

    target = tr.find_all_by_invoice_id(46)
    target_2 = tr.find_all_by_invoice_id(0)

    assert_equal 2, target[0].id
    assert_equal [], target_2
  end

  def test_it_can_find_all_by_credit_card_number
    tr = TransactionRepository.new('./data/transactions_short.csv', self)

    target = tr.find_all_by_credit_card_number(4149654190362629)
    target_2 = tr.find_all_by_credit_card_number(0)

    assert_equal 10, target[0].id
    assert_equal [], target_2
  end

  def test_it_can_find_all_by_result
    tr = TransactionRepository.new('./data/transactions_short.csv', self)

    target = tr.find_all_by_result("success")
    target_2 = tr.find_all_by_result("none")

    assert_equal 9, target.count
    assert_equal [], target_2
  end
end

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
end

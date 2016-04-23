require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < MiniTest::Test

  attr_reader :tr

  def setup
    test_helper = TestHelper.new
    @tr = TransactionRepository.new(test_helper.transactions)
  end

  def test_it_returns_an_array_of_all_transactions
    assert_equal Array, tr.all.class
    assert_equal 3, tr.all.count
  end

  def test_it_can_find_by_transaction_id
    assert_equal 7, tr.find_by_id(7).id
  end

  def test_it_can_find_all_by_invoice_id
    assert_equal 2, tr.find_all_by_invoice_id(10).count
    assert_equal [10, 10], invoice_ids_from_transactions(tr.find_all_by_invoice_id(10))
  end

  private

    def invoice_ids_from_transactions(transactions)
      transactions.map do |transaction|
        transaction.invoice_id
      end
    end

end

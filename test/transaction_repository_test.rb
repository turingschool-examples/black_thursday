require_relative 'test_helper'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  attr_reader :tr

  def setup
    @tr = TransactionRepository.new("./test/data/transactions_truncated.csv", self)
  end

  def test_transaction_repo_instantiates
    assert_equal TransactionRepository, @tr.class
  end

  def test_transaction_repo_opens_csv_into_array
    assert_equal Array, @tr.all_transactions.class
  end

  def test_it_returns_transaction_instance
    assert_equal Transaction, @tr.all[1].class
  end
end

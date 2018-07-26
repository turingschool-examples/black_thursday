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
    assert_instance_of Transactions, @transaction_repository.transactions[0]
    assert_instance_of Transactions, @transaction_repository.transactions[25]
  end
end

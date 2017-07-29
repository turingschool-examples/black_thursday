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
end

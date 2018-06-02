# frozen_string_literal: false

require_relative 'test_helper'
require './lib/sales_engine'
require './lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(transactions: './data/transactions.csv')
    @tr = @se.transactions
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @tr
  end

  def test_transaction_repo_holds_all_instances_of_transactions
    assert_equal 4985, @tr.all.length
  end

  def test_all_returns_array_of_all_transaction_objects
    transactions = @tr.all
    assert transactions.all? do |transaction|
      transaction.class == Transaction
    end
  end
end

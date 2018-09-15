require_relative './test_helper'
require_relative '../lib/transaction'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  def test_it_exists
    tr = TransactionRepository.new("./data/transactions.csv")

    assert_instance_of TransactionRepository, tr
  end
end 

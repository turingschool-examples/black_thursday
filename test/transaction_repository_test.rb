require_relative 'test_helper'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  def test_new_instance
    tr = TransactionRepository.new("./test/data/transactions_fixture.csv", self)

    assert_instance_of TransactionRepository, tr
  end

  def test_new_instance_of_transaction
    tr = TransactionRepository.new("./test/data/transactions_fixture.csv", self)

    assert_instance_of Transaction, tr.contents[1]
  end


end

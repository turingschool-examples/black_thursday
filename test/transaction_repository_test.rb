require 'minitest/autorun'
require 'minitest/pride'
require './lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  def test_it_exists
    tr = TransactionRepository.new

    assert_instance_of TransactionRepository, tr
  end
end

require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/transaction_repo'

class TransactionRepositoryTest < Minitest::Test

  def test_it_exist
    transaction_repo = TransactionRepository.new

    assert_instance_of TransactionRepository, transaction_repo
  end

end

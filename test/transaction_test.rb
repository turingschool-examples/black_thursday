require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/transaction'

class TransactionTest < Minitest::Test

  def test_it_exist
    transaction = Transaction.new

    assert_instance_of Transaction, transaction
  end

end

require_relative 'test_helper'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test

  def setup
    @t = Transaction.new

  end

  def test_if_class_creates

    assert_instance_of Transaction, @t
  end

end

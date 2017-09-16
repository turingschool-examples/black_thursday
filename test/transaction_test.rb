require_relative 'test_helper'
require './lib/transaction'

class TransactionTest < Minitest::Test

  def setup
    @trx = Transaction.new({:id => 6})             
  end

  def test_instance_of_transaction_class
    assert_instance_of Transaction, @trx    
  end
end
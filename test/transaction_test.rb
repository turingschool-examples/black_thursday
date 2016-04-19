require './test/test_helper'
require './lib/sales_engine'
require './lib/transaction'

class TransactionTest < Minitest::Test

  def test_setup
    assert Transaction.new.class
  end
end

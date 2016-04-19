require './test/test_helper'
require './lib/transaction'
# require './lib/sales_engine'


class TransactionTest < Minitest::Test

  def test_setup
    assert Transaction.new.class
  end
end

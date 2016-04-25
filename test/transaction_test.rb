require_relative 'test_helper'
require_relative '../lib/transaction'
# require_relative '../lib/sales_engine'


class TransactionTest < Minitest::Test

  def test_setup
    assert Transaction.new.class
  end
end

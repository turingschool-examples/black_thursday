require './test/test_helper'
require './lib/transaction'

class TransactionTest < Minitest::Test
  def setup
    transaction = ({
      id: "1",
      invoice_id: "2179",
      credit_card_number: "4068631943231473",
      credit_card_expiration_date: "0217",
      result: "success",
      created_at: "2012-02-26 20:56:56 UTC",
      updated_at: "2012-02-26 20:56:56 UTC"
    })
    @tr = Transaction.new(transaction)
  end

  def assert_transaction_exists
    assert_instance_of Transaction, @tr
  end

  def assert_transaction_has_attributes
    assert_equal 1, @tr.id
    assert_equal 2179, @tr.invoice_id
    assert_equal "4068631943231473", @tr.credit_card_number
    assert_equal "0217", @tr.credit_card_expiration_date
    assert_equal :success, @tr.result
    assert_equal Time.parse("2012-02-26 20:56:56 UTC"), @tr.created_at
    assert_equal Time.parse("2012-02-26 20:56:56 UTC"), @tr.updated_at
  end
end

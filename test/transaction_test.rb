require './lib/transaction'
require './test/test_helper'


class TransactionTest < Minitest::Test
  def test_it_exists
    transaction = Transaction.new(1, 2, "4242424242424242", "0220",
                                  "success", "2016-01-11 09:34:06 UTC",
                                  "2016-01-11 09:34:06 UTC",
                                  self)

    assert_instance_of Transaction, transaction
  end

  def test_it_is_created_with_state
    transaction = Transaction.new(1, 2, "4242424242424242", "0220",
                                  "success", "2016-01-11 09:34:06 UTC",
                                  "2016-01-11 09:34:06 UTC",
                                  self)

    assert_equal 1, transaction.id
    assert_equal 2, transaction.invoice_id
    assert_equal "4242424242424242", transaction.credit_card_number
    assert_equal "0220", transaction.credit_card_expiration_date
    assert_equal "success", transaction.result
    assert_equal Time.parse("2016-01-11 09:34:06 UTC"), transaction.created_at
    assert_equal Time.parse("2016-01-11 09:34:06 UTC"), transaction.updated_at
  end

end

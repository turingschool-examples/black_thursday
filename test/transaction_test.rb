require_relative 'test_helper'
require './lib/transaction'

class TransactionTest < Minitest::Test
  DATA = {
    id:                            1,
    invoice_id:                    10,
    credit_card_number:           '4068631943231473',
    credit_card_expiration_date:  '0217',
    result:                       'success',
    created_at:                   '2016-01-11 09:34:06 UTC',
    updated_at:                   '2007-06-04 21:35:10 UTC'
    }

  def test_it_exists
    t = Transaction.new(DATA)

    assert_instance_of Transaction, t
  end

  def test_it_has_attributes
    t = Transaction.new(DATA)

    assert_equal 1, t.id
    assert_equal 10, t.invoice_id
    assert_equal '4068631943231473', t.credit_card_number
    assert_equal '0217', t.credit_card_expiration_date
    assert_equal :success, t.result
    assert_instance_of Time, t.created_at
    assert_instance_of Time, t.updated_at
  end
end

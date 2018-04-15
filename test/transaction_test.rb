require_relative 'test_helper'
require_relative '../lib/transaction'
require_relative '../lib/sales_engine'

# Test Transaction class
class TransactionTest < Minitest::Test
  def setup
    @time = Time.now
    @trans = Transaction.new(
      id:                           3,
      invoice_id:                   8,
      credit_card_number:           '1234567890123456',
      credit_card_expiration_date:  '0518',
      result:                       'success',
      created_at:                   @time,
      updated_at:                   @time
    )
  end

  def test_it_exists
    assert_instance_of Transaction, @trans
  end

  def test_it_has_attributes
    assert_equal 3, @trans.id
    assert_equal 8, @trans.invoice_id
    assert_equal '1234567890123456', @trans.credit_card_number
    assert_equal '0518', @trans.credit_card_expiration_date
    assert_equal :success, @trans.result
    assert_equal @time, @trans.created_at
    assert_equal @time, @trans.updated_at
  end
end

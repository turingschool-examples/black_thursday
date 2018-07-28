require_relative './test_helper'
require './lib/transaction'

class TransactionTest < Minitest::Test
  def setup
    @transaction_items =
        { id: 1,
          invoice_id: 2171,
          credit_card_number: '4068631943231471',
          credit_card_expiration_date: '0211',
          result: 'success',
          created_at: '2001-01-01 20:56:56 UTC',
          updated_at: '2011-01-01 20:56:56 UTC'
        }

    @transaction = Transaction.new(@transaction_items)
  end

  def test_it_exists
    assert_instance_of Transaction, @transaction
  end

  def test_it_has_attributes
    assert_equal 1, @transaction.id
    assert_equal 2171, @transaction.invoice_id
    assert_equal '4068631943231471', @transaction.credit_card_number
    assert_equal '0211', @transaction.credit_card_expiration_date
    assert_equal :success, @transaction.result
    assert_equal Time, @transaction.created_at.class
    assert_equal Time, @transaction.updated_at.class
  end
end

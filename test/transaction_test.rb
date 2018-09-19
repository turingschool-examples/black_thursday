require_relative './test_helper'
require_relative '../lib/transaction'
require 'bigdecimal'

class TransactionTest < Minitest::Test
  def test_it_exists
    t = Transaction.new({id: 6,
                        invoice_id: 8,
                        credit_card_number: '4242424242424242',
                        credit_card_expiration_date: '0220',
                        result: :success,
                        created_at: Time.now,
                        updated_at: Time.now
                        })
    assert_instance_of Transaction, t
  end

  def test_it_has_attributes
    t = Transaction.new({id: 6,
                        invoice_id: 8,
                        credit_card_number: '4242424242424242',
                        credit_card_expiration_date: '0220',
                        result: :success,
                        created_at: Time.now,
                        updated_at: Time.now
                        })
    assert_equal 6, t.id
    assert_equal "4242424242424242", t.credit_card_number
    assert_equal :success, t.result
  end

  def test_it_returns_time_for_created_and_updated
    t = Transaction.new({id: 6,
                        invoice_id: 8,
                        credit_card_number: '4242424242424242',
                        credit_card_expiration_date: '0220',
                        result: :success,
                        created_at: Time.now,
                        updated_at: Time.now
                        })
    assert_instance_of Time, t.created_at
    assert_instance_of Time, t.updated_at
  end
end

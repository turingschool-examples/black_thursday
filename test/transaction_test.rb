# frozen_string_literal: false

require_relative 'test_helper'
require './lib/transaction'

class TransactionTest < Minitest::Test
  def setup
    @args = {
      id:                          '6',
      invoice_id:                  '8',
      credit_card_number:         '4242424242424242',
      credit_card_expiration_date: '0220',
      result:                      'success',
      created_at:                  '2016-01-11 09:34:06 UTC',
      updated_at:                  '2007-06-04 21:35:10 UTC'
    }
    @transaction = Transaction.new(@args)
  end

  def test_it_exits
    assert_instance_of Transaction, @transaction
  end

  def test_it_has_attributes
    assert_equal 6, @transaction.id
    assert_equal 8, @transaction.invoice_id
    assert_equal '4242424242424242', @transaction.credit_card_number
    assert_equal '0220', @transaction.credit_card_expiration_date
  end

  def test_time_attributes_for_created
    assert_instance_of Time, @transaction.created_at
    assert_equal 2016, @transaction.created_at.year
    assert_equal 34, @transaction.created_at.min
  end

  def test_time_attributes_for_updated
    assert_instance_of Time, @transaction.updated_at
    assert_equal 0o6, @transaction.updated_at.mon
    assert_equal 21, @transaction.updated_at.hour
  end
end

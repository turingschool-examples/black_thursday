# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/emoji'

require './lib/transaction'

# Transaction class tests
class TransactionTest < Minitest::Test
  def setup
    @transaction = Transaction.new(
      id:                          6,
      invoice_id:                  8,
      credit_card_number:          '4242424242424242',
      credit_card_expiration_date: '0220',
      result:                      'success',
      created_at:                  Time.now,
      updated_at:                  Time.now
    )
  end

  def test_it_exists
    assert_instance_of Transaction, @transaction
  end

  def test_it_has_attributes
    assert_equal 6, @transaction.id
    assert_equal 8, @transaction.invoice_id

    expected = '4242424242424242'
    actual   = @transaction.credit_card_number
    assert_equal expected, actual

    expected2 = '0220'
    actual2   = @transaction.credit_card_expiration_date
    assert_equal expected2, actual2

    assert_equal 'success', @transaction.result

    assert_instance_of Time, @transaction.created_at
    assert_instance_of Time, @transaction.updated_at
  end

  def test_certain_attributes_can_be_changed
    @transaction.result = 'failed'
    assert_equal 'failed', @transaction.result

    @transaction.credit_card_number = '1010101010101010'
    assert_equal '1010101010101010', @transaction.credit_card_number

    @transaction.credit_card_expiration_date = '0122'
    assert_equal '0122', @transaction.credit_card_expiration_date
  end
end

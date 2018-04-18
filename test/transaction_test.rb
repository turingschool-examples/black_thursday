# frozen_string_literal: true

require 'timecop'
require_relative 'test_helper'
require './lib/transaction'

# transaction test
class TransactionTest < Minitest::Test
  def setup
    Timecop.freeze

    @t = Transaction.new({
      id:  6,
      invoice_id:  8,
      credit_card_number:  '4242424242424242',
      credit_card_expiration_date:  '0220',
      result:  'success',
      created_at:  Time.now.to_s,
      updated_at:  Time.now.to_s,
    }, 'parent' )
  end

  def teardown
    Timecop.return
  end

  def test_it_exists
    assert_instance_of Transaction, @t
  end

  def test_attributes
    assert_equal 6, @t.id
    assert_equal 8, @t.invoice_id
    assert_equal '4242424242424242', @t.credit_card_number
    assert_equal '0220', @t.credit_card_expiration_date
    assert_equal :success, @t.result
    assert_equal Time.now.to_s, @t.created_at.to_s
    assert_equal Time.now.to_s, @t.updated_at.to_s
  end

  def test_change_attributes
    assert_equal '4242424242424242', @t.credit_card_number
    assert_equal '0220', @t.credit_card_expiration_date
    assert_equal :success, @t.result

    @t.change_credit_card_number('111111111111111')
    @t.change_expiration_date('1111')
    @t.change_result('failed')

    assert_equal '111111111111111', @t.credit_card_number
    assert_equal '1111', @t.credit_card_expiration_date
    assert_equal :failed, @t.result
  end
end

#frozen_string_literal: true

require_relative 'test_helper'
require './lib/transaction'

# transaction test
class TransactionTest < Minitest::Test
  def setup
    @t = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => '4242424242424242',
      :credit_card_expiration_date => '0220',
      :result => 'success',
      :created_at => Time.now.to_s,
      :updated_at => Time.now.to_s,
    }, 'parent' )
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
  end
end

require_relative 'test_helper'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test
  def setup
    @t = Transaction.new({
        :id => 6,
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => Time.now,
        :updated_at => Time.now
      }, self)
  end

  def test_transaction_id_can_be_read
    assert_equal 6, @t.id
  end

  def test_invoice_id_can_be_read
    assert_equal 8, @t.invoice_id
  end

  def test_cc_number_can_be_read
    assert_equal 4242424242424242, @t.credit_card_number
  end

  def test_created_at_returns_time
    actual = @t.created_at.class

    assert_equal Time, actual
  end
end

require_relative 'test_helper'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test
  attr_reader :t

  def setup
    @t = Transaction.new({:id => 6,
                          :invoice_id => 8,
                          :credit_card_number => "4242424242424242",
                          :credit_card_expiration_date => "0220",
                          :result => "success",
                          :created_at => Time.now,
                          :updated_at => Time.now
                        })

  end

  def test_it_exists
    assert_instance_of Transaction, t
  end

  def test_it_returns_id
    assert_equal 6, t.id
  end

  def test_it_returns_invoice_id
    assert_equal 8, t.invoice_id
  end

  def test_it_returns_cc_num
    assert_equal 4242424242424242, t.credit_card_number
  end

  def test_it_returns_cc_exp_date
    assert_equal "0220", t.credit_card_expiration_date
  end

  def test_it_returns_result_of_transaction
    assert_equal "success", t.result
  end

  def test_it_knows_created_at_date
    assert_instance_of Time, t.created_at
  end

  def test_it_returns_updated_at_date
    assert_instance_of Time, t.updated_at
  end
end

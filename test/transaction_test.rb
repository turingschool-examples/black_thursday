require_relative 'test_helper'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test
  attr_reader :t

  def setup
    @t = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.new.to_s,
      :updated_at => Time.new.to_s
    })
  end

  def test_it_created_instance_of_invoice_class
    assert_equal Transaction, t.class
  end

  def test_it_returns_id
    assert_equal 6, t.id
  end

  def test_it_returns_invoice_id
    assert_equal 8, t.invoice_id
  end

  def test_it_returns_credit_card_number
    assert_equal "4242424242424242", t.credit_card_number
  end

  def test_it_returns_credit_card_expiration_date
    assert_equal "0220", t.credit_card_expiration_date
  end

  def test_it_returns_result
    assert_equal "success", t.result
  end

  def test_it_returns_current_time
    time = t.created_at
    current_time = Time.new
    assert_equal Time, time.class
    assert_equal current_time.year, time.year
  end

  def test_it_returns_updated_time
    time = t.updated_at
    current_time = Time.new
    assert_equal Time, time.class
    assert_equal current_time.year, time.year
  end
end

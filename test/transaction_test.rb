require_relative 'test_helper'
require './lib/transaction'
require 'pry'

class TransactionTest < Minitest::Test
  def setup
    @t = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => "2012-02-26 20:56:56 UTC",
      :updated_at => "2012-02-26 20:56:56 UTC"
      })
  end

  def test_it_exists
    assert_instance_of Transaction, @t
  end

  def test_it_can_take_an_id
    assert_equal 6, @t.id
  end

  def test_it_can_take_an_invoice_id
    assert_equal 8, @t.invoice_id
  end

  def test_it_can_take_a_credit_card_number
    assert_equal "4242424242424242", @t.credit_card_number
  end

  def test_it_can_take_a_credit_card_expiration_date
    assert_equal "0220", @t.credit_card_expiration_date
  end

  def test_it_can_take_transaction_result
    assert_equal "success", @t.result
  end

  def test_it_can_take_a_created_at_date
    assert_instance_of Time, @t.created_at
  end

  def test_it_can_take_a_created_at_date
    assert_instance_of Time, @t.updated_at
  end
  
end

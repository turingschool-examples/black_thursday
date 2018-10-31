require './test/test_helper'
require './lib/transaction'
require 'bigdecimal'

class TransactionTest < Minitest::Test
  def setup
    @now = Time.now
    @transaction = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => @now,
      :updated_at => @now
    })
  end

  def test_it_exists
    assert_instance_of Transaction, @transaction
  end

  def test_it_has_an_id
    assert_equal 6, @transaction.id
  end

  def test_it_has_an_invoice_id
    assert_equal 8, @transaction.invoice_id
  end

  def test_it_has_a_credit_card_number
    assert_equal "4242424242424242", @transaction.credit_card_number
  end

  def test_it_has_a_credit_card_expiration
    assert_equal "0220", @transaction.credit_card_expiration_date
  end

  def test_it_has_a_result
    assert_equal "success", @transaction.result
  end

  def test_it_has_a_created_at_date
    assert_equal @now, @transaction.created_at
  end

  def test_it_has_an_updated_at_date
    assert_equal @now, @transaction.updated_at
  end
end

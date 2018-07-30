require_relative 'test_helper'
require_relative '../lib/transaction'
require 'time'
require 'pry'

class TransactionTest < MiniTest::Test
  def setup
    @transaction = Transaction.new({
      id: 6,
      invoice_id: 9,
      credit_card_number: "4242424242424242",
      credit_card_expiration_date: "1020",
      result: "success",
      created_at: "1972-07-30 18:08:53 UTC",
      updated_at: "2016-01-11 18:30:35 UTC"
      })
  end

  def test_it_exists
    assert_instance_of Transaction, @transaction
  end

  def test_it_has_an_id_number
    assert_equal 6, @transaction.id
  end

  def test_it_has_a_invoice_id
    assert_equal 9, @transaction.invoice_id
  end

  def test_it_has_a_credit_card_number
    assert_equal "4242424242424242", @transaction.credit_card_number
  end

  def test_it_has_a_credit_card_expiration_date
    assert_equal "1020", @transaction.credit_card_expiration_date
  end

  def test_it_has_a_result
    assert_equal :success, @transaction.result
  end

  def test_it_has_a_created_time
    assert_equal Time.parse("1972-07-30 18:08:53 UTC"), @transaction.created_at
  end

  def test_it_has_a_updated_time
    assert_equal Time.parse("2016-01-11 18:30:35 UTC"), @transaction.updated_at
  end
end

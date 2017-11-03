require_relative 'test_helper'
require './lib/transaction'

class TransactionTest < Minitest::Test
  def test_it_initializes_with_attributes
    parent = mock("parent")
    transaction = Transaction.new({
      :id => 332211,
      :invoice_id => 12345,
      :credit_card_number => 1234567812345678,
      :credit_card_expiration_date => 0312,
      :result => "success",
      :created_at => "2017-11-03",
      :updated_at => "2017-11-04"
      }, parent)

    assert_instance_of Transaction, transaction
    assert_equal 332211, transaction.id
    assert_equal 12345, transaction.invoice_id
    assert_equal 1234567812345678, transaction.credit_card_number
    assert_equal 0312, transaction.credit_card_expiration_date
    assert_equal "success", transaction.result
    assert_equal Time.parse('2017-11-03'), transaction.created_at
    assert_equal Time.parse('2017-11-04'), transaction.updated_at
    assert transaction.parent
  end

  def test_it_initializes_with_other_attributes
    parent = mock("parent")
    transaction = Transaction.new({
      :id => 443322,
      :invoice_id => 23456,
      :credit_card_number => 8765432187654321,
      :credit_card_expiration_date => 1111,
      :result => "failed",
      :created_at => "2010-11-01",
      :updated_at => "2017-12-02"
      }, parent)

    assert_instance_of Transaction, transaction
    assert_equal 443322, transaction.id
    assert_equal 23456, transaction.invoice_id
    assert_equal 8765432187654321, transaction.credit_card_number
    assert_equal 1111, transaction.credit_card_expiration_date
    assert_equal "failed", transaction.result
    assert_equal Time.parse('2010-11-01'), transaction.created_at
    assert_equal Time.parse('2017-12-02'), transaction.updated_at
    assert transaction.parent
  end

end

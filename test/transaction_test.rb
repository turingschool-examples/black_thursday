require_relative 'test_helper'
require_relative '../lib/transaction'
require_relative '../lib/data_parser'

class TransactionTest < Minitest::Test
  include DataParser

  def test_transaction_class_exists
    assert_instance_of Transaction, Transaction.new({
    :id                          => 6,
    :invoice_id                  => 8,
    :credit_card_number          => "4242424242424242",
    :credit_card_expiration_date => "0220",
    :result                      => "success",
    :created_at                  => Time.now,
    :updated_at                  => Time.now
  })
  end

  def test_it_can_access_transaction_attributes
    t = Transaction.new({
    :id                          => 6,
    :invoice_id                  => 8,
    :credit_card_number          => "4242424242424242",
    :credit_card_expiration_date => "0220",
    :result                      => "success",
    :created_at                  => Time.now,
    :updated_at                  => Time.now
  })
      assert_equal 6, t.id
      assert_equal 8, t.invoice_id
      assert_equal "4242424242424242", t.credit_card_number
      assert_equal "0220", t.credit_card_expiration_date
      assert_equal "success", t.result
      assert_respond_to t, :created_at
      assert_respond_to t, :updated_at
  end

  def test_transaction_can_parse_rows
    file = './data/transactions.csv'
    assert_instance_of Array, parse_data(file)
  end
end

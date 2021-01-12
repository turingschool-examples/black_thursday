require_relative './test_helper'
require './lib/transaction'
require 'time'
require 'mocha/minitest'

class TransactionTest < Minitest::Test
  def test_it_exists_and_has_attributes
    repo = mock
    time = Time.now
    transaction = Transaction.new({
                  :id => 6,
                  :invoice_id => 8,
                  :credit_card_number => "4242424242424242",
                  :credit_card_expiration_date => "0220",
                  :result => "success",
                  :created_at => Time.now
                  }, repo)

    assert_instance_of Transaction, transaction
    assert_equal 6, transaction.id
    assert_equal 8, transaction.invoice_id
    assert_equal "4242424242424242", transaction.credit_card_number
    assert_equal "0220", transaction.credit_card_expiration_date
    assert_equal :success, transaction.result
    assert_equal true, transaction.created_at > time
    assert_equal true, transaction.updated_at > time
  end
end

require_relative 'test_helper'
require_relative '../lib/transaction'
require 'pry'

class TransactionTest < Minitest::Test

  attr_reader :transaction

  def setup
    @transaction = Transaction.new({ :id => "6",
                                     :invoice_id => "8",
                                     :credit_card_number => "4242424242424242",
                                     :credit_card_expiration_date => "0220",
                                     :result => "success",
                                     :created_at => "2012-02-26 20:56:56 UTC",
                                     :updated_at => "2012-02-26 20:56:56 UTC" }, self)
  end

  def test_new_instance

    assert_instance_of Transaction, transaction
  end

  def test_return_id

    assert_equal 6, transaction.id
  end

  def test_return_invoice_id

    assert_equal 8, transaction.invoice_id
  end

  def test_return_credit_card_number

    assert_equal 4242424242424242, transaction.credit_card_number
  end

  def test_return_credit_card_expiration_date

    assert_equal "0220", transaction.credit_card_expiration_date
  end

  def test_return_result

    assert_equal "success", transaction.result
  end

  def test_return_created_at

    assert_instance_of Time, transaction.created_at
  end

  def test_return_updated_at

    assert_instance_of Time, transaction.updated_at
  end


end

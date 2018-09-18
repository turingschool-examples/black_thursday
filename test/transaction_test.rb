require_relative 'test_helper'

require 'time'

require_relative '../lib/transaction'


class TransactionTet < Minitest::Test

  def setup
    # CSV: 1,2179,4068631943231473,0217,success,2012-02-26 20:56:56 UTC,2012-02-26 20:56:56 UTC
    @hash = {
              :id                          => "1",
              :invoice_id                  => "2179",
              :credit_card_number          => "4068631943231473",
              :credit_card_expiration_date => "0217",
              :result                      => "success",
              :created_at                  => "2012-02-26 20:56:56 UTC",
              :updated_at                  => "2012-02-26 20:56:56 UTC"
    }
    @transaction = Transaction.new(@hash)
  end

  def test_it_exists
    assert_instance_of Transaction, @transaction
  end

  def test_it_gets_attributes
    assert_equal 1, @transaction.id
    assert_equal 2179, @transaction.invoice_id
    assert_equal "4068631943231473", @transaction.credit_card_number
    assert_equal "0217", @transaction.credit_card_expiration_date
    assert_equal :success, @transaction.result
    assert_instance_of Time, @transaction.created_at
    assert_equal "2012-02-26 20:56:56 UTC", @transaction.created_at.to_s
    assert_instance_of Time, @transaction.updated_at
    assert_equal "2012-02-26 20:56:56 UTC", @transaction.updated_at.to_s
  end

end

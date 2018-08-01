require 'simplecov'
SimpleCov.start
require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test

  def setup
    @transaction = Transaction.new({id: 1,
                                    invoice_id: 1,
                                    credit_card_number: 1234567890,
                                    credit_card_expiration_date: "2012-08-09",
                                    result: "success",
                                    created_at: "2012-08-08",
                                    updated_at: "2018-09-15"
                                    })
  end

  def test_it_exists
    assert_instance_of Transaction, @transaction
  end

  def test_it_has_attributes
    assert_equal @transaction.id, 1
    assert_equal @transaction.credit_card_number, 1234567890
  end

end

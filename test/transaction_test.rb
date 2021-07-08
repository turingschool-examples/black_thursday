require_relative 'test_helper'
require "./lib/transaction"

class TransactionTest < Minitest::Test
  attr_reader :transaction

  def setup
    @transaction = Transaction.new({:id => 6,
                                    :invoice_id => 8,
                                    :credit_card_number => "4242424242424242",
                                    :credit_card_expiration_date => "0220",
                                    :result => "success",
                                    :created_at => "2017-11-05",
                                    :updated_at => "2017-11-05"
                                  })
  end

  def test_it_exist
    assert_instance_of Transaction, transaction
  end

  def test_can_access_attributes
    assert_equal 6, transaction.id
    assert_equal 8, transaction.invoice_id
    assert_equal 4242424242424242, transaction.credit_card_number
    assert_equal "0220", transaction.credit_card_expiration_date
    assert_equal "success", transaction.result
    assert_equal "2017-11-05 00:00:00 -0600", transaction.created_at.to_s
    assert_equal "2017-11-05 00:00:00 -0600", transaction.updated_at.to_s
  end
end

require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/transaction'

class TransactionTest < Minitest::Test

  def setup
    transaction = ({:id => 6,
                    :invoice_id => 8,
                    :credit_card_number => "4242424242424242",
                    :credit_card_expiration_date => "0220",
                    :result => "success",
                    :created_at => "2012-02-26 20:56:56 UTC",
                    :updated_at => "2012-02-26 20:56:56 UTC"})

    @transaction = Transaction.new(transaction, "Transaction_Repo")
  end


  def test_it_exist
    assert_instance_of Transaction, @transaction
    assert_equal 6, @transaction.id
    assert_equal 8, @transaction.invoice_id
    assert_equal "4242424242424242", @transaction.credit_card_number
    assert_equal "0220", @transaction.credit_card_expiration_date
    assert_equal "success", @transaction.result
    assert_instance_of Time, @transaction.created_at
    assert_instance_of Time, @transaction.updated_at
  end




end

require 'minitest/autorun'
require 'minitest/pride'
require './lib/transaction'
require 'time'


class TransactionTest < Minitest::Test

  def test_it_exists
    transaction = Transaction.new({ :id => 6,
                          :invoice_id => 8,
                          :credit_card_number => "4242424242424242",
                          :credit_card_expiration_date => "0220",
                          :result => "success",
                          :created_at => Time.now.to_s,
                          :updated_at => Time.now.to_s
                          }, nil)
    assert_instance_of Transaction, transaction
  end

  def test_it_can_have_attributes
    transaction = Transaction.new({ :id => 6,
                          :invoice_id => 8,
                          :credit_card_number => "4242424242424242",
                          :credit_card_expiration_date => "0220",
                          :result => "success",
                          :created_at => Time.now.to_s,
                          :updated_at => Time.now.to_s
                          }, nil)
    assert_equal 6, transaction.id
    assert_equal 8, transaction.invoice_id
    assert_equal 4242424242424242, transaction.credit_card_number
    assert_equal "0220", transaction.credit_card_expiration_date
    assert_equal "success", transaction.result
    end


end

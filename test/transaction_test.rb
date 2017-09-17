require_relative 'test_helper'
require './lib/transaction'

class TransactionTest < Minitest::Test

  def setup
    @trx = Transaction.new({:id => 6,
                            :invoice_id => 8,
                            :credit_card_number => "4242424242424242",
                            :credit_card_expiration_date => "0220",
                            :result => "success",
                            :created_at => Time.now,
                            :updated_at => Time.now
                            })           
  end

  def test_instance_of_transaction_class
    assert_instance_of Transaction, @trx    
  end

  def test_transaction_has_an_id
    assert_equal 6, @trx.id 
  end

  def test_transaction_has_an_invoice_id
    assert_equal 8, @trx.invoice_id
  end

  def test_transaction_has_a_credit_card_number
    assert_equal "4242424242424242", @trx.credit_card_number
  end

  def test_transaction_has_a_credit_card_expiration_date
    assert_equal "0220", @trx.credit_card_expiration_date
  end

  def test_unit_price_returns_result
    assert_equal "success", @trx.result
  end

  def test_instance_of_the_created_time
    assert_instance_of Time, @trx.created_at
  end

  def test_instance_of_the_updated_time
    assert_instance_of Time, @trx.updated_at
  end

end
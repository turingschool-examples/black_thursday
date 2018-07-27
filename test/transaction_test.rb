require_relative 'test_helper'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test

  def setup
    @transaction_item = Transaction.new({
                :id => 6,
                :invoice_id => 8,
                :credit_card_number => "4242424242424242",
                :credit_card_expiration_date => "0220",
                :result => :success,
                :created_at => Time.now,
                :updated_at => Time.now
              })
  end
  
  def test_it_exists
    assert_instance_of Transaction, @transaction_item
  end

  def test_it_has_id
    assert_equal 6, @transaction_item.id
  end

  def test_it_has_an_invoice_id
    assert_equal 8, @transaction_item.invoice_id
  end

  def test_it_has_a_credit_card_number
    expected = "4242424242424242"
    assert_equal expected, @transaction_item.credit_card_number
  end

  def test_it_has_credit_card_expiration_date
      assert_equal "0220", @transaction_item.credit_card_expiration_date
  end

  def test_it_has_a_credit_card_result
    assert_equal :success, @transaction_item.result
  end

  def test_it_has_created_at_and_updated_at_time
    assert_instance_of Time, @transaction_item.created_at
    assert_instance_of Time, @transaction_item.updated_at
  end
end

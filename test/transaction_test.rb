require_relative './test_helper'

class TransactionTest < Minitest::Test
  def setup
    @time = Time.now.to_s
    @t = Transaction.new({
                        :id => 6,
                        :invoice_id => 8,
                        :credit_card_number => "4242424242424242",
                        :credit_card_expiration_date => "0220",
                        :result => "success",
                        :created_at => @time,
                        :updated_at => @time
                      })
  end
  
  def test_it_exists
    assert_instance_of Transaction, @t
  end
  
  def test_it_can_return_id
    assert_equal 6, @t.id
  end
  
  def test_it_can_return_invoice_id
    assert_equal 8, @t.invoice_id
  end
  
  def test_it_can_return_credit_card_number
    assert_equal "4242424242424242", @t.credit_card_number
  end
  
  def test_it_can_return_credit_card_expiration_date
    assert_equal "0220", @t.credit_card_expiration_date
  end
  
  def test_it_can_return_transaction_result
    assert_equal :success, @t.result
  end
  
  def test_it_can_return_created_at_time
    assert_equal Time.parse(@time), @t.created_at
  end
  
  def test_it_can_return_updated_at_time
    assert_equal Time.parse(@time), @t.updated_at
  end
end

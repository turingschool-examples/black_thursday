require_relative 'test_helper'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test
  def set_up
    trans_info = ({:id => "1", :invoice_id => "2179", :credit_card_number => "4068631943231470", :credit_card_expiration_date => "0217", :result => "success", :created_at => "2012-02-26 20:56:56 UTC", :updated_at => "2012-02-26 20:56:56 UTC"})
    Transaction.new(trans_info, [])
  end

  def test_item_exists
    assert_instance_of Transaction, set_up
  end

  def test_created_at_instance_of_time
    assert_instance_of Time, set_up.created_at
  end

  def test_updated_at_instance_of_time
    assert_instance_of Time, set_up.updated_at
  end

  def test_has_an_id
    assert_equal 1, set_up.id
  end

  def test_invoice_id
    assert_equal 2179, set_up.invoice_id
  end

  def test_credit_card_number
    assert_equal 4068631943231470, set_up.credit_card_number
  end

  def test_credit_card_experiration
    assert_equal "0217", set_up.credit_card_expiration_date
  end

  def test_result
    assert_equal "success", set_up.result
  end
end

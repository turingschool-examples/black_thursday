require_relative 'test_helper'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test
  def setup
    transaction = ({:id => "10", :invoice_id => "3715", :credit_card_number => "4613250127567219", :credit_card_expiration_date => "0313", :result => "success", :created_at => "2012-02-26 20:56:56 UTC", :updated_at => "2012-02-26 20:56:57 UTC"})
    Transaction.new(transaction, [])
  end

  def test_it_exists
    assert_instance_of Transaction, setup
  end

  def test_id_returns_correct_integer
    assert_equal 10, setup.id
  end

  def test_invoice_id_is_correct_integer
    assert_equal 3715, setup.invoice_id
  end

  def test_cc_number_is_correct_integer
    assert_equal 4613250127567219, setup.credit_card_number
  end

  def test_cc_exp_date_is_correct_integer
    assert_equal "0313", setup.credit_card_expiration_date
  end

  def test_it_produces_correct_result
    assert_equal "success", setup.result
  end

  def test_time_returns_time_exists
    assert_instance_of Time, setup.created_at
    assert_instance_of Time, setup.updated_at
  end
end

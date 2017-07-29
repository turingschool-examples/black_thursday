require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require_relative '../lib/transaction'
require 'time'
# require './lib/sales_engine'


class TransactionTest < Minitest::Test

  def setup
    @transaction = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => "2012-02-26 20:56:57 UTC",
      :updated_at => "2012-02-26 20:56:57 UTC"
    })
  end

  def test_it_exists
    assert_instance_of Transaction, @transaction
  end

  def test_it_has_id
    assert_equal 6, @transaction.id
  end

  def test_it_has_invoice_id
    assert_equal 8, @transaction.invoice_id
  end

  def test_it_has_credit_card_number
    assert_equal "4242424242424242", @transaction.credit_card_number
  end
  
  def test_it_has_credit_card_expiration_date
    assert_equal "0220", @transaction.credit_card_expiration_date
  end

  def test_it_has_result
    assert_equal "success", @transaction.result
  end

  def test_it_has_created_at
    assert_instance_of Time, @transaction.created_at
  end

  def test_it_has_updated_at
    assert_instance_of Time, @transaction.updated_at
  end

end

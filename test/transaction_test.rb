require_relative './test_helper'
require 'time'

class TransactionTest < Minitest::Test

  def setup
    item_path          = "./data/items.csv"
    merchant_path      = "./data/merchants.csv"
    invoice_path       = "./data/invoices.csv"
    invoice_item_path  = "./data/invoice_items.csv"
    customer_path      = "./data/customers.csv"
    transaction_path   = "./data/transactions.csv"

    arguments = {
                  :items     => item_path,
                  :merchants => merchant_path,
                  :invoices  => invoice_path,
                  :invoice_items => invoice_item_path,
                  :customers => customer_path,
                  :transactions => transaction_path
                }
    @engine = SalesEngine.from_csv(arguments)
    @transaction = @engine.transactions.find_by_id(1)
  end

  def test_id_returns_the_transaction_id
    assert_equal 1, @transaction.id
    assert_equal Fixnum, @transaction.id.class
  end

  def test_invoice_id_returns_the_invoice_id
    assert_equal 2179, @transaction.invoice_id
    assert_equal Fixnum, @transaction.invoice_id.class
  end

  def test_credit_card_number_returns_the_credit_card_number
    assert_equal "4068631943231473", @transaction.credit_card_number
    assert_equal String, @transaction.credit_card_number.class
  end

  def test_credit_card_expiration_date_returns_the_credit_card_expiration
    assert_equal "0217", @transaction.credit_card_expiration_date
    assert_equal String, @transaction.credit_card_expiration_date.class
  end

  def test_result_returns_the_result
    assert_equal :success, @transaction.result
    assert_equal Symbol, @transaction.result.class
  end

  def test_created_at_returns_a_Time_instance_for_the_date_the_invoice_item_was_created
    assert_equal  Time.parse("2012-02-26 20:56:56 UTC"), @transaction.created_at
    assert_equal Time, @transaction.created_at.class
  end

  def test_updated_at_returns_a_time_instance_for_the_date_the_invoice_item_was_last_updated
    assert_equal Time.parse("2012-02-26 20:56:56 UTC"), @transaction.updated_at
    assert_equal Time, @transaction.updated_at.class
  end
end

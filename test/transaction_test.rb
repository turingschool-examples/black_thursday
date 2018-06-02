require './test_helper'
require './lib/transaction'
require './lib/file_loader'
require './lib/sales_engine'
require 'mocha/minitest'
require 'bigdecimal'
require 'pry'

class TransactionTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv({
    :items => "./data/mock.csv",
    :merchants => "./data/mock.csv",
    :invoices => "./data/mock.csv",
    :invoice_items => "./data/mock.csv",
    :transactions => "./data/transactions.csv"
    })

    @t = se.transactions
    @transaction = @t.find_by_id(1)
  end

  def test_returns_transaction_id
    assert_equal 1, @transaction.id
    assert_instance_of Fixnum, @transaction.id
  end

  def test_returns_invoice_id
    assert_equal 2179, @transaction.invoice_id
    assert_instance_of Fixnum, @transaction.invoice_id
  end

  def test_returns_creditcard_as_a_string
    assert_equal "4068631943231473", @transaction.credit_card_number
    assert_instance_of String, @transaction.credit_card_number
  end

  def test_returns_creditcard_experation_as_a_string
    assert_equal "0217", @transaction.credit_card_number_expiration_date
    assert_instance_of String, @transaction.credit_card_number_expiration_date
  end

  def test_returns_result_as_a_symbol
    assert_equal :success, @transaction.result
    assert_instance_of Symbol, @transaction.result
  end

  def test_returns_created_at_as_time_object
    assert_equal Time.parse("2012-02-26 20:56:56 UTC"), @transaction.created_at
    assert_instance_of Time, @transaction.created_at
  end

  def test_returns_updated_at_as_time_object
    assert_equal Time.parse("2012-02-26 20:56:56 UTC"), @transaction.updated_at
    assert_instance_of Time, @transaction.updated_at
  end

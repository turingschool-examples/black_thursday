require 'simplecov'
SimpleCov.start
gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction'
require_relative '../lib/sales_engine'

class TransactionClassTest < Minitest::Test

  def setup
    # sales_engine = "sales engine"
    @sales_engine = SalesEngine.from_csv({
      :items     => 'data/items.csv',
      :merchants => 'data/merchants.csv',
      :invoices => 'data/invoices.csv',
      :invoice_items => 'data/invoice_items.csv',
      :transactions => 'data/transactions.csv',
      :customers => 'data/customers.csv'
    })
    @transaction1 = Transaction.new(@sales_engine, {:id => "1",
      :invoice_id => "2179",
      :credit_card_number => "406831943231473",
      :credit_card_expiration_date => "1115",
      :result => "success",
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"})

    @transaction2 = Transaction.new(@sales_engine, {:id => "2",
      :invoice_id => "46",
      :credit_card_number => "1234567899991234",
      :credit_card_expiration_date => "1025",
      :result => "failed",
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"})

    @transaction3 = Transaction.new(@sales_engine, {:id => '1370',
        :invoice_id => '46',
        :credit_card_number => '4938390307931021',
        :credit_card_expiration_date => '1018',
        :result => 'success',
        :created_at => '2012-02-26 20:57:42 UTC',
        :updated_at => '2012-02-26 20:57:42 UTC'})
  end

  def test_can_get_transaction_id
    assert_equal 1, @transaction1.id
    assert_equal 2, @transaction2.id
  end

  def test_can_get_credit_card_expiration_date
    assert_equal "1115", @transaction1.credit_card_expiration_date
    assert_equal "1025", @transaction2.credit_card_expiration_date
  end

  def test_can_get_credit_card_number_from_transaction
    assert_equal 406831943231473, @transaction1.credit_card_number
    assert_equal 1234567899991234, @transaction2.credit_card_number
  end

  def test_can_get_invoice_id_from_transaction
    assert_equal 2179, @transaction1.invoice_id
    assert_equal 46, @transaction2.invoice_id
  end

  def test_can_get_the_result_of_the_transaction
    assert_equal "success", @transaction1.result
    assert_equal "failed", @transaction2.result
  end

  def test_can_get_time_object_transaction_was_created_and_updated
    assert_equal Time, @transaction1.created_at.class
    assert_equal Time, @transaction1.updated_at.class
  end

  def test_can_find_by_invoice_id
    assert_equal 46, @transaction3.invoice.id
    assert_equal 2179, @transaction1.invoice.id
  end
end

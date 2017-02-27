require './test/test_helper'
require './lib/transaction'
require_relative '../lib/sales_engine'
require_relative '../lib/transaction_repository'

class TransactionTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :merchants => "./data/merchants.csv",
      :items     => "./data/items.csv",
      :customers => "./data/customers.csv",
      :invoices  => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv"
      })

    @tr = Transaction.new({
      :id         => 22,
      :invoice_id => 3543,
      :credit_card_number => 4172068877354384,
      :credit_card_expiration_date => 1117,
      :result      => "success",
      :created_at  => "2012-02-26 20:56:57 UTC",
      :updated_at  => "2012-02-26 20:56:57 UTC"
      })
  end

  def test_it_exists
    assert_instance_of Transaction, @t
  end

  def test_it_returns_integer_id
    assert_equal 22, @t.id
  end

  def test_it_returns_invoice_id
    assert_equal 3543, @t.invoice_id
  end

  def test_it_returns_credit_card_number
    assert_equal 4172068877354384, @t.credit_card_number
  end

  def test_it_returns_credit_card_expiration_date
    assert_equal 1117, @t.credit_card_expiration_date
  end

  def test_it_returns_transaction_result
    assert_equal "success", @t.result
  end

  def test_it_returns_instance_of_time_for_date_transaction_was_first_created
    assert_instance_of Time, @t.created_at
  end

  def test_it_returns_instance_of_time_for_date_transaction_was_last_modified
    assert_instance_of Time, @t.updated_at
  end
end

# CHECK FORMAT OF RETURNED CREDIT CARD NUMBER WITHOUT TAB OR SPACE

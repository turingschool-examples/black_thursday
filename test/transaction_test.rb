require_relative 'test_helper'
require_relative '../lib/transaction'
require_relative 'sales_engine_methods'

class TransactionTest < Minitest::Test
  include SalesEngineMethods
  attr_reader :t, :t2, :se

  def setup
    create_sales_engine
    @t = Transaction.new({
      :id => 4,
      :invoice_id => 4126,
      :credit_card_number => "4048033451067370",
      :credit_card_expiration_date => "0313",
      :result => "success",
      :created_at => "2012-02-26 20:56:56 UTC",
      :updated_at => "2012-02-26 20:56:56 UTC"
      }, "transaction_repo")

  end

  def test_it_exists
    assert_instance_of Transaction, t
  end

  def test_it_knows_id
    assert_instance_of Fixnum, t.id
    assert_equal 4, t.id
  end

  def test_it_knows_invoice_id
    assert_instance_of Fixnum, t.invoice_id
    assert_equal 4126, t.invoice_id
  end

  def test_it_knows_credit_card_number
    assert_equal 4048033451067370, t.credit_card_number
  end

  def test_it_knows_credit_card_expiration
    assert_equal "0313", t.credit_card_expiration_date
  end

  def test_it_knows_result
    assert_equal "success", t.result
  end

  def test_it_knows_what_time_it_was_created
    assert_instance_of Time, t.created_at
    assert_equal 2012, t.created_at.year
  end

  def test_it_knows_when_it_was_last_updated
    assert_instance_of Time, t.updated_at
    assert_equal 02, t.updated_at.month
  end

  def test_it_knows_transaction_repo
    assert_equal "transaction_repo", t.transaction_repo
  end

  def test_it_can_find_invoice_based_on_transaction_id
    transaction = se.transactions.find_by_id(8)
    assert_instance_of Invoice, transaction.invoice
    assert_equal 1, transaction.invoice.id
  end

end

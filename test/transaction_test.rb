require "./test/test_helper"
require "./lib/transaction"

class TransactionTest < Minitest::Test

  attr_reader :transaction

  def setup
    csv_hash = {:id => 6,
                :invoice_id => 8,
                :credit_card_number => "4242424242424242",
                :credit_card_expiration_date => "0220",
                :result => "success",
                :created_at => "2016-01-11 09:34:06 UTC",
                :updated_at => "2007-06-04 21:35:10 UTC"
               }
    @transaction = Transaction.new('fake_transaction_repository', csv_hash)
  end

  def test_transaction_exists
    assert_instance_of Transaction, transaction
  end

  def test_transaction_has_id
    assert_equal 6, transaction.id
  end

  def test_transaction_has_invoice_id
    assert_equal 8, transaction.invoice_id
  end

  def test_transaction_has_credit_card_number
    assert_equal 4242424242424242, transaction.credit_card_number
  end

  def test_transaction_has_credit_card_expiration_date
    assert_equal 220, transaction.credit_card_expiration_date
  end

  def test_transaction_has_result
    assert_equal "success", transaction.result
  end

  def test_transaction_has_created_at_time
    assert_equal Time.parse("2016-01-11 09:34:06 UTC"), transaction.created_at
  end

  def test_transaction_has_updated_at_time
    assert_equal Time.parse("2007-06-04 21:35:10 UTC"), transaction.updated_at
  end

end

require './test/test_helper'
require './lib/transaction'
require 'csv'

class TransactionTest < Minitest::Test
  attr_reader :transaction_rows, :transaction_1

  def setup
    fixture = CSV.open('./test/fixtures/transactions_fixture.csv',
                         headers: true,
                         header_converters: :symbol)
    @transaction_rows = fixture.to_a
    @transaction_1 = Transaction.new(transaction_rows[0])
  end

  def test_has_fixnum_ids
    assert_equal 1, transaction_1.id
    assert_equal 2179, transaction_1.invoice_id
  end

  def test_has_fixnum_cc_number
    assert_equal 4068631943231473, transaction_1.credit_card_number
  end

  def test_has_string_cc_expiration_date
    assert_equal '0217', transaction_1.credit_card_expiration_date
  end

  def test_has_time_objects
    assert_instance_of Time, transaction_1.created_at
    assert_instance_of Time, transaction_1.updated_at
  end

  def test_has_result_symbol
    assert_equal "success", transaction_1.result
  end

  def test_method_is_successful_returns_boolean
    assert_equal true, transaction_1.is_successful?
    transaction_8 = Transaction.new(transaction_rows[7])
    assert_equal false, transaction_8.is_successful?
  end

  def test_method_invoice_queries_parent
    mock_tr = Minitest::Mock.new
    transaction = Transaction.new(transaction_rows[0], mock_tr)
    mock_tr.expect(:find_invoice_by_id, nil, [2179])
    transaction.invoice
    assert mock_tr.verify
  end

  def test_method_weekday_created_returns_string
    assert_equal "Sunday", transaction_1.weekday_created
  end
end

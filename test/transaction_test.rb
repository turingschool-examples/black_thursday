require './test/test_helper'

class TransactionTest < Minitest::Test

  attr_reader :transaction

  def setup
    @transaction = Transaction.new(id: "1", invoice_id: "2179", credit_card_number: "4068631943231473", credit_card_expiration_date: "0217", result: "success", created_at: "2012-02-26 20:56:56 UTC", updated_at: "2012-02-26 20:56:56 UTC")
  end

  def test_id
    assert_equal 1, transaction.id
  end

  def test_invoice_id
    assert_equal 2179, transaction.invoice_id
  end

  def test_credit_card_number
    assert_equal 4068631943231473, transaction.credit_card_number
  end

  def test_credit_card_expiration_date
    assert_equal "0217", transaction.credit_card_expiration_date
  end

  def test_result
    assert_equal "success", transaction.result
  end

  def test_created_at
    assert_equal Time.parse("2012-02-26 20:56:56 UTC"), transaction.created_at
  end

  def test_updated_at
    assert_equal Time.parse("2012-02-26 20:56:56 UTC"), transaction.created_at
  end
end
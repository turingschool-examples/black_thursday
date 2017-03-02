require './test/test_helper'

class TransactionTest < Minitest::Test

  attr_reader :transaction_1

  def setup
    @transaction_1 = Transaction.new(id: "1", invoice_id: "2179", credit_card_number: "4068631943231473", credit_card_expiration_date: "0217", result: "success", created_at: "2012-02-26 20:56:56 UTC", updated_at: "2012-02-26 20:56:56 UTC")
  end

  def test_id
    assert_equal 1, transaction_1.id
  end

  def test_invoice_id
    assert_equal 2179, transaction_1.invoice_id
  end

  def test_credit_card_number
    assert_equal 4068631943231473, transaction_1.credit_card_number
  end

  def test_credit_card_expiration_date
    assert_equal "0217", transaction_1.credit_card_expiration_date
  end

  def test_result
    assert_equal "success", transaction_1.result
  end

  def test_created_at
    assert_equal Time.parse("2012-02-26 20:56:56 UTC"), transaction_1.created_at
  end

  def test_updated_at
    assert_equal Time.parse("2012-02-26 20:56:56 UTC"), transaction_1.created_at
  end

  def test_invoice
    se = SalesEngine.from_csv({
    :merchants    => "./data/merchants.csv",
    :items        => "./data/items.csv",
    :invoices     => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :customers    => "./data/customers.csv"
    })
    assert_instance_of Invoice, se.transactions.transactions.first.invoice
  end

end

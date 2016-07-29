require './test/test_helper'
require './lib/sales_engine'

class TransactionTest < Minitest::Test

  def test_that_it_has_an_id
    transaction = Transaction.new({ id: 33, invoice_id: 496, credit_card_number: "9876987698769876", credit_card_expiration_date: "0117", result: :success, created_at: "2016-07-26 02:23:16 UTC", updated_at: "1970-04-01 12:45:13 UTC"})

    assert_equal 33, transaction.id
  end

  def test_that_it_has_an_invoice_id
    transaction = Transaction.new({ id: 33, invoice_id: 496, credit_card_number: "9876987698769876", credit_card_expiration_date: "0117", result: :success, created_at: "2016-07-26 02:23:16 UTC", updated_at: "1970-04-01 12:45:13 UTC"})

    assert_equal 496, transaction.invoice_id
  end

  def test_that_it_has_a_credit_card_number
    transaction = Transaction.new({ id: 33, invoice_id: 496, credit_card_number: "9876987698769876", credit_card_expiration_date: "0117", result: :success, created_at: "2016-07-26 02:23:16 UTC", updated_at: "1970-04-01 12:45:13 UTC"})

    assert_equal "9876987698769876", transaction.credit_card_number
  end

  def test_that_it_has_a_credit_card_expiration_date
    transaction = Transaction.new({ id: 33, invoice_id: 496, credit_card_number: "9876987698769876", credit_card_expiration_date: "0117", result: :success, created_at: "2016-07-26 02:23:16 UTC", updated_at: "1970-04-01 12:45:13 UTC"})

    assert_equal "0117", transaction.credit_card_expiration_date
  end

  def test_that_it_has_a_result
    transaction = Transaction.new({ id: 33, invoice_id: 496, credit_card_number: "9876987698769876", credit_card_expiration_date: "0117", result: :success, created_at: "2016-07-26 02:23:16 UTC", updated_at: "1970-04-01 12:45:13 UTC"})

    assert_equal :success, transaction.result
  end

  def test_that_it_finds_when_created
    transaction = Transaction.new({ id: 33, invoice_id: 496, credit_card_number: "9876987698769876", credit_card_expiration_date: "0117", result: :success, created_at: "2016-07-26 02:23:16 UTC", updated_at: "1970-04-01 12:45:13 UTC"})

    assert_equal Time.new(2016, 07, 26, 02, 23, 16, "-00:00"), transaction.created_at
  end

  def test_that_it_finds_when_updated
    transaction = Transaction.new({ id: 33, invoice_id: 496, credit_card_number: "9876987698769876", credit_card_expiration_date: "0117", result: "success", created_at: "2016-07-26 02:23:16 UTC", updated_at: "1970-04-01 12:45:13 UTC"})

    assert_equal Time.new(1970, 04, 01, 12, 45, 13, "-00:00"), transaction.updated_at
  end

  def test_a_transaction_points_to_its_invoice
    se = SalesEngine.from_csv({ transactions: "./test/samples/transactions_sample.csv", invoices: "./test/samples/invoices_sample.csv" })
    transaction = se.transactions.find_by_id(2)

    assert_equal true, transaction.invoice.is_a?(Invoice)
    assert_equal 12336837, transaction.invoice.merchant_id
  end

end

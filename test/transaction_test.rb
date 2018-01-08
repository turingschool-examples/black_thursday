require_relative "test_helper"
require_relative "../lib/transaction"
require_relative "../lib/sales_engine"

class TransactionTest < Minitest::Test

  def test_it_exists
    trans = Transaction.new({id: 5, invoice_id: 3715, credit_card_number: 4297222478855497, credit_card_expiration_date: 0313, result: "success",
                             created_at: "2012-02-26", updated_at: "2012-02-26"}, parent = nil
                            )

    assert_instance_of Transaction, trans
  end

  def test_it_has_attributes
    trans = Transaction.new({id: 5, invoice_id: 3715, credit_card_number: 4297222478855497, credit_card_expiration_date: 0313, result: "success",
                             created_at: "2012-02-26", updated_at: "2012-02-26"}, parent = nil
                            )

    assert_equal 5, trans.id
    assert_equal 3715, trans.invoice_id
  end

  def test_transaction_returns_all_items_of_given_transaction
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    trans = Transaction.new({id: 1, invoice_id: 2179, credit_card_number: 4068631943231473, credit_card_expiration_date: "0217", result: "success", created_at: "2012-02-26 20:56:56 UTC", updated_at: "2012-02-26 20:56:56 UTC"}, se)

    assert_equal 1, trans.id
    assert_equal 2179, trans.invoice_id
    assert_equal 4068631943231473, trans.credit_card_number
    assert_equal "0217", trans.credit_card_expiration_date
    assert_equal "success", trans.result
    assert_equal "2012-02-26 20:56:56 UTC", trans.created_at.to_s
    assert_equal "2012-02-26 20:56:56 UTC", trans.updated_at.to_s
  end

  def test_transaction_returns_correct_trasactions
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    trans_repo = TransactionRepo.new(se, "./data/transactions.csv")
    trans = trans_repo.transactions.first

    assert_instance_of Transaction, trans
    assert_instance_of Array, trans_repo.transactions
    assert_equal 4985, trans_repo.transactions.count
  end

  def test_invoice_returns_invoice_of_transaction
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    trans = Transaction.new({id: 1, invoice_id: 74, credit_card_number: 4068631943231473, credit_card_expiration_date: "0217", result: "success", created_at: "2012-02-26 20:56:56 UTC", updated_at: "2012-02-26 20:56:56 UTC"}, se)

    assert_instance_of Invoice, trans.invoice
    assert_equal 74, trans.invoice.id
  end
end

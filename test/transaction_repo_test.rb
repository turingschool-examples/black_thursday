require_relative "test_helper"
require_relative "../lib/transaction_repo"
require_relative "../lib/sales_engine"

class TransactionRepoTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    trans_repo = TransactionRepo.new(se, "./data/transactions.csv")

    assert_instance_of TransactionRepo, trans_repo
  end

  def test_all_returns_all_merchants
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    trans_repo = TransactionRepo.new(se, "./data/transactions.csv")

    assert_equal 4985, trans_repo.all.count
    assert_instance_of Transaction, trans_repo.transactions.first
  end

  def test_find_by_id_finds_transaction_by_id
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    trans_repo = TransactionRepo.new(se, "./data/transactions.csv")

    expected = trans_repo.find_by_id(5)

    assert_equal 5, expected.id
    assert_equal "success", expected.result
    assert_equal "2012-02-26 20:56:56 UTC", expected.created_at
    assert_equal "2012-02-26 20:56:56 UTC", expected.updated_at
    assert_equal 1215, expected.credit_card_expiration_date
    assert_equal 4297222478855497, expected.credit_card_number
    assert_equal 3715, expected.invoice_id
  end

  def test_find_all_by_invoice_id_finds_transaction_by_invoice_id
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    trans_repo = TransactionRepo.new(se, "./data/transactions.csv")

    expected = trans_repo.find_all_by_invoice_id(2880)

    assert_equal 2, expected.length
    assert_instance_of Array, expected
    assert_instance_of Transaction, expected.first
    assert_equal "2012-02-26 20:56:59 UTC", expected.first.created_at
    assert_equal 818, expected.first.credit_card_expiration_date
    assert_equal 4327191927608552, expected.first.credit_card_number
    assert_equal 72, expected.first.id
    assert_equal 2880, expected.first.invoice_id
    assert_equal "failed", expected.first.result
  end

  def test_find_all_by_credit_card_number_finds_transaction_by_ccn
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    trans_repo = TransactionRepo.new(se, "./data/transactions.csv")

    expected = trans_repo.find_all_by_credit_card_number(4172068877354384)

    assert_equal "2012-02-26 20:56:57 UTC", expected.first.created_at
    assert_equal 1117, expected.first.credit_card_expiration_date
    assert_equal 4172068877354384, expected.first.credit_card_number
    assert_equal 22, expected.first.id
    assert_equal 3543, expected.first.invoice_id
    assert_equal "success", expected.first.result
  end

  def test_case_name
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    trans_repo = TransactionRepo.new(se, "./data/transactions.csv")

    expected = trans_repo.find_all_by_result("success")

    assert_equal "2012-02-26 20:56:56 UTC", expected.first.created_at
    assert_equal 217, expected.first.credit_card_expiration_date
    assert_equal 4068631943231473, expected.first.credit_card_number
    assert_equal 1, expected.first.id
    assert_equal 2179, expected.first.invoice_id
    assert_equal "success", expected.first.result
  end

end

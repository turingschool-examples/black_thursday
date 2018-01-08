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
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    trans = Transaction.new({id: 5, invoice_id: 3715, credit_card_number: 4297222478855497, credit_card_expiration_date: 0313, result: "success",
                             created_at: "2012-02-26", updated_at: "2012-02-26"}, parent = nil 
                            )

    assert_equal 5, trans.id
    assert_equal 3715, trans.invoice_id
    assert_equal 4297222478855497, trans.credit_card_number
    assert_equal 0313, trans.credit_card_expiration_date
    assert_equal "success", trans.result
    assert_instance_of Time, trans.created_at
    assert_instance_of Time, trans.updated_at
  end

  def test_transaction_returns_correct_trasactions
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    trans_repo = TransactionRepo.new(se, "./data/transactions.csv")
    trans = trans_repo.transactions.first

    assert_instance_of Transaction, trans
    assert_instance_of Array, trans_repo.transactions
    assert_equal 4985, trans_repo.transactions.count
  end

end



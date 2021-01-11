require './test/test_helper'

class TransactionRepositoryTest < Minitest::Test

  def setup
    item_path          = "./data/items.csv"
    merchant_path      = "./data/merchants.csv"
    invoice_path       = "./data/invoices.csv"
    invoice_item_path  = "./data/invoice_items.csv"
    customer_path      = "./data/customers.csv"
    transaction_path   = "./data/transactions.csv"
    arguments = {
                  :items     => item_path,
                  :merchants => merchant_path,
                  :invoices  => invoice_path,
                  :invoice_items => invoice_item_path,
                  :customers     => customer_path,
                  :transactions => transaction_path
                }
    @engine = SalesEngine.from_csv(arguments)
  end

  def test_all_returns_all_transactions
    expected = @engine.transactions.all
    assert_equal 4985, expected.count
  end

  def test_find_by_id_returns_a_transaction_matching_the_given_id
    skip
    id = 2
    expected = @engine.transactions.find_by_id(id)

    assert_equal id, expected.id
    assert_instance_of Transaction, expected.class
  end

  def find_all_by_invoice_id_returns_all_transactions_matching_the_given_id
    skip
    id = 2179
    expected = @engine.transactions.find_all_by_invoice_id(id)

    assert_equal 2, expected.length
    assert_equal id, expected.id
    assert_instance_of Transaction, expected.first.class

    id = 14560
    expected = engine.transactions.find_all_by_invoice_id(id)

    assert_equal true, expected.empty?
  end

  def test_find_all_by_credit_card_number_returns_all_transactions_matching_given_credit_card_number
    skip
    credit_card_number = "4848466917766329"
    expected = @engine.transactions.find_all_by_credit_card_number(credit_card_number)

    assert_equal 1, expected.length
    assert_instance_of Transaction, expected.first.class
    assert_equal credit_card_number, expected.first.credit_card_number
  end

  def test_find_all_by_result_returns_all_transactions_matching_given_result
    skip
    result = :success
    expected = @engine.transactions.find_all_by_result(result)

    assert_equal 4158, expected.length
    assert_instance_of Transaction, expected.first.class
    assert_equal result, expected.first.result

    result = :failed
    expected = @engine.transactions.find_all_by_result(result)

    assert_equal 827, expected.length
    assert_instance_of Transaction, expected.first.class
    assert_equal result, expected.first.result
  end

end

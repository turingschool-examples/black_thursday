require './test/test_helper'
require './lib/sales_engine'

class TransactionRepositoryTest < Minitest::Test

  def test_all_stores_an_array
    se = SalesEngine.from_csv({ transactions: "./test/samples/transactions_sample.csv" })
    tr = se.transactions

    assert_equal true, tr.all.is_a?(Array)
  end

  def test_it_populates_the_correct_number_of_transactions
    se = SalesEngine.from_csv({ transactions: "./test/samples/transactions_sample.csv" })
    tr = se.transactions

    assert_equal 100, tr.all.length
  end

  def test_that_it_can_find_a_transaction_by_its_id
    se = SalesEngine.from_csv({ transactions: "./test/samples/transactions_sample.csv" })
    tr = se.transactions

    assert_equal "0314", tr.find_by_id(7).credit_card_expiration_date
  end

  def test_that_it_returns_nil_for_invalid_id
    se = SalesEngine.from_csv({ transactions: "./test/samples/transactions_sample.csv" })
    tr = se.transactions

    assert_equal nil, tr.find_by_id(919)
  end

  def test_that_find_all_by_invoice_id_returns_an_array
    se = SalesEngine.from_csv({ transactions: "./test/samples/transactions_sample.csv" })
    tr = se.transactions

    assert_equal [], tr.find_all_by_invoice_id(919)
  end

  def test_that_find_all_by_invoice_id_returns_an_array_of_proper_length
    se = SalesEngine.from_csv({ transactions: "./test/samples/transactions_sample.csv" })
    tr = se.transactions

    assert_equal 3, tr.find_all_by_invoice_id(2179).length
  end

  def test_that_find_all_by_credit_card_number_returns_an_array
    se = SalesEngine.from_csv({ transactions: "./test/samples/transactions_sample.csv" })
    tr = se.transactions

    assert_equal [], tr.find_all_by_credit_card_number(9999999999999999)
  end

  def test_that_find_all_by_credit_card_number_returns_an_array_of_proper_length
    se = SalesEngine.from_csv({ transactions: "./test/samples/transactions_sample.csv" })
    tr = se.transactions

    assert_equal 3, tr.find_all_by_credit_card_number(4068631943231473).length
  end

  def test_that_find_all_by_result_returns_an_array
    se = SalesEngine.from_csv({ transactions: "./test/samples/transactions_sample.csv" })
    tr = se.transactions

    assert_equal [], tr.find_all_by_result(:good_enough)
  end

  def test_that_find_all_by_result_returns_an_array_of_proper_length
    se = SalesEngine.from_csv({ transactions: "./test/samples/transactions_sample.csv" })
    tr = se.transactions

    assert_equal 23, tr.find_all_by_result(:failed).length
  end

end

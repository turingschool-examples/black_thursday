require "./test/test_helper"
require 'bigdecimal'
require "./lib/transaction_repository"

class TransactionRepositoryTest < MiniTest::Test

  def setup
    @transaction = TransactionRepository.new("./test/fixtures/transactions_fixtures.csv")
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @transaction
  end

  def test_all_returns_array_of_transactions
    assert_instance_of Array, @transaction.all
    assert_equal 3 ,@transaction.all.count
  end

  def test_find_by_id_returns_matching_transaction
    assert_equal 4576, @transaction.find_by_id(4576).id
  end

  def test_find_all_by_invoice_id_returns_an_array
    assert_instance_of Transaction, @transaction.find_all_by_invoice_id(3675)[0]

    assert_equal 2213, @transaction.find_all_by_invoice_id(3675)[0].id

  end

  def test_find_all_by_invoice_id_returns_empty_array_when_given_dummy_id
    assert_equal [], @transaction.find_all_by_invoice_id(3)
  end

  def test_find_all_by_credit_card_number_returns_array_of_transactions
    assert_instance_of Transaction, @transaction.find_all_by_credit_card_number(4.76315E+15)[0]
    assert_equal 4763150000000000, @transaction.find_all_by_credit_card_number(4.76315E+15)[0].credit_card_number
  end

  def test_find_all_by_result_returns_array_of_transactions
    assert_instance_of Transaction, @transaction.find_all_by_result("success")[0]

    assert_equal 3, @transaction.find_all_by_result("success").count
  end
end

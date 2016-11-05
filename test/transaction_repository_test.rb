require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class TransactionRepositoryTest < Minitest::Test
  attr_reader   :repository,
                :sales_engine

  def setup
    # @sales_engine = SalesEngine.from_csv(
    # {:transactions => "./fixture/transactions.csv"})
    # @repository = sales_engine.transactions
  end

  def test_it_can_create_transaction_repository
    skip
    assert repository
  end

  def test_all_returns_instances_of_transactions
    skip
    assert_instance_of Array, repository.all
  end

  def test_it_can_return_instance_of_transaction_with_matching_id
    skip
    assert repository.find_by_id()
    assert_instance_of transaction, repository.find_by_id()
    assert repository.find_by_id()
    assert_instance_of transaction, repository.find_by_id()
    assert_nil repository.find_by_id()
  end

  def test_it_can_return_all_transactions_that_match_invoice_id
    skip
    assert repository.find_all_by_invoice_id()
    assert repository.find_all_by_invoice_id()
    assert_equal [], repository.find_all_by_invoice_id()
  end

  def test_it_can_return_all_transactions_that_match_credit_card_number
    skip
    assert repository.find_all_by_credit_card_number()
    assert repository.find_all_by_credit_card_number()
    assert_equal [], repository.find_all_by_credit_card_number()
  end

  def test_it_can_return_all_transactions_that_match_result
    skip
    assert repository.find_all_by_result()
    assert repository.find_all_by_result()
    assert_equal [], repository.find_all_by_result()
  end

  def test_that_an_transaction_repo_knows_who_its_parent_is
    skip
    assert_equal sales_engine, repository.parent
    assert_instance_of SalesEngine, repository.parent
  end

end
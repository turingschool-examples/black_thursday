require_relative 'test_helper'
require_relative '../lib/transaction_repository'
require_relative '../lib/sales_engine'

class TransactionRepositoryTest < Minitest::Test

  def test_transaction_repository_exists
    tr = TransactionRepository.new('./data/transactions.csv', self)

    assert_instance_of TransactionRepository, tr
  end

  def test_transaction_repo_has_sales_engine_access
    se = SalesEngine.from_csv({
      :transactions => './data/transactions.csv'
      })
    tr = se.transactions

    assert_instance_of SalesEngine, tr.sales_engine
  end

  def test_transaction_repo_has_file_path
    tr = TransactionRepository.new('./data/transactions.csv', self)

    assert_equal './data/transactions.csv', tr.file_path
  end

  def test_transaction_repo_can_load_id_repo
    tr = TransactionRepository.new('./data/transactions.csv', self)

    assert_instance_of Hash, tr.id_repo
    refute tr.id_repo.empty?
    assert_equal 4985, tr.id_repo.count
  end

  def test_transaction_repo_can_get_all_transactions
    tr = TransactionRepository.new('./data/transactions.csv', self)
    transactions = tr.all

    assert_instance_of Array, transactions
    refute transactions.empty?
    assert_instance_of Transaction, transactions[0]
    assert_equal 4985, transactions.count
  end

  def test_transaction_repo_can_fin_by_id
    tr = TransactionRepository.new('./data/transactions.csv', self)
    transaction = tr.find_by_id(4332)

    assert_instance_of Transaction, transaction
    assert_equal "0313", transaction.credit_card_expiration_date
    assert_equal "success", transaction.result
  end

  def test_transaction_repo_find_by_id_returns_array_on_bad_search
    tr = TransactionRepository.new('./data/transactions.csv', self)
    transaction = tr.find_by_id(99999999999)

    assert_nil transaction
  end

  def test_transaction_repo_can_find_all_by_invoice_id
    tr = TransactionRepository.new('./data/transactions.csv', self)
    transactions = tr.find_all_by_invoice_id(442)

    assert_instance_of Array, transactions
    assert_equal 2, transactions.count
  end

  def test_transaction_repo_find_all_by_invoice_id_returns_empty_array_on_bad_search
    tr = TransactionRepository.new('./data/transactions.csv', self)
    transactions = tr.find_all_by_invoice_id(99999999999999)

    assert_equal [], transactions
  end

  def test_transaction_repo_can_find_all_by_credit_card_number
    tr = TransactionRepository.new('./data/transactions.csv', self)
    transactions = tr.find_all_by_credit_card_number(4875556043697027)

    assert_instance_of Array, transactions
    assert_equal 1, transactions.count
    assert_equal 3008, transactions[0].id
  end

end

require_relative 'test_helper'
require_relative './../lib/transaction'
require_relative './../lib/transaction_repository'
require_relative './../lib/sales_engine'

class TransactionRepositoryTest < Minitest::Test

  attr_reader :engine, :repository

  def setup
    @engine = SalesEngine.from_csv({
    items: "./test/fixtures/truncated_items.csv",
    merchants: "./test/fixtures/truncated_merchants.csv",
    transactions: "./test/fixtures/truncated_transactions"
                                  })

    @repository = TransactionRepository.new("./test/fixtures/truncated_transactions.csv", @engine)
  end

  def test_it_exists
    assert_instance_of TransactionRepository, repository
  end

  def test_it_has_correct_attributes
    assert_instance_of Transaction, repository.transactions.first
    assert_instance_of Array, repository.transactions
    assert_instance_of SalesEngine, repository.parent
  end

  def test_load_csv_can_load_file
    assert_instance_of CSV, repository.load_csv("./test/fixtures/truncated_transactions.csv")
  end

  def test_all_returns_all_transactions
    assert_instance_of Array, repository.all
    assert_equal 99, repository.all.length
    assert_instance_of Transaction, repository.all.first
    assert_instance_of Transaction, repository.all.last
  end

  def test_find_by_id
    assert_instance_of Transaction, repository.find_by_id(10)
    assert_equal "2179", repository.find_by_id(5).invoice_id
    assert_equal 'success', repository.find_by_id(1).result
  end

end

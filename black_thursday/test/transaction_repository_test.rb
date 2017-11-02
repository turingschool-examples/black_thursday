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
  end

end

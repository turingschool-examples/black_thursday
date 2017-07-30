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

end

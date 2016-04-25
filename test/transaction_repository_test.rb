require_relative 'test_helper'
require_relative '../lib/transaction_repository'
require_relative '../lib/transaction'
require_relative '../lib/sales_engine'


class TransactionRepositoryTest < Minitest::Test

  attr_reader :transaction_repo, :se
  def setup
    @se = SalesEngine.from_csv({
      :transactions => './data/small_transactions.csv'})
    @transaction_repo = @se.transactions
  end

  def test_all_returns_array
    assert_equal 10, transaction_repo.all.length
  end

  def test_all_returns_array_class
    assert_equal Array, transaction_repo.all.class
  end

  def test_we_can_find_by_id
    assert_equal 1, transaction_repo.find_by_id(1).id
  end

  def test_we_find_all_by_price_for_no_matches
    assert_equal [], transaction_repo.find_all_by_invoice_id(666)
  end

  def test_we_can_find_all_by_invoice_id
    assert_equal 2, transaction_repo.find_all_by_invoice_id(1).invoice_id
  end

end

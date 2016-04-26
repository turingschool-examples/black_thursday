require_relative 'test_helper'
require_relative '../lib/transaction_repository'
require_relative '../lib/sales_engine'

class TransactionRepositoryTest < Minitest::Test
  attr_reader :se, :transactions, :transaction_repo
  def setup
    @se = SalesEngine.from_csv({
      :transactions => "./data/small_transactions.csv" })
    @transaction_repo = @se.transactions
  end

  def test_we_can_return_all_transaction_instances
    assert_equal 10, transaction_repo.all.length
    assert transaction_repo.all[0].is_a?(Transaction)
  end

  def test_we_can_find_by_id
    assert_equal 1, transaction_repo.find_by_id(1).id
    assert transaction_repo.find_by_id(1).is_a?(Transaction)
  end

  def test_we_can_find_all_by_invoice_id
    assert_equal 1, transaction_repo.find_all_by_invoice_id(1)[1].invoice_id
    assert transaction_repo.find_all_by_invoice_id(750).is_a?(Array)
  end

  def test_we_can_find_all_by_credit_card_number
    assert_equal 2, transaction_repo.find_all_by_credit_card_number(4177816490204479).length
    assert transaction_repo.find_all_by_credit_card_number("vghulk").is_a?(Array)
    assert_equal 0, transaction_repo.find_all_by_credit_card_number("vghulk").length
  end

  def test_we_can_return_one_or_more_matches_by_result
    assert_equal 2, transaction_repo.find_all_by_result("failed").length
    assert transaction_repo.find_all_by_result("success").is_a?(Array)
    assert_equal 8, transaction_repo.find_all_by_result("success").length
  end

end

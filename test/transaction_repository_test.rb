require_relative 'test_helper'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  attr_reader :tr

  def setup
    @tr = TransactionRepository.new("./test/data/transactions_truncated.csv", self)
  end

  def test_transaction_repo_instantiates
    assert_equal TransactionRepository, @tr.class
  end

  def test_transaction_repo_opens_csv_into_array
    assert_equal Array, @tr.all_transactions.class
  end

  def test_it_returns_transaction_instance
    assert_equal Transaction, @tr.all[1].class
  end

  def test_it_can_find_by_id
    actual = @tr.find_by_id(1)
    expected = @tr.all[0]

    assert_equal expected, actual
  end

  def test_it_can_find_all_by_invoice_id
    actual = @tr.find_all_by_invoice_id(46)
    expected = [@tr.all[1]]

    assert_equal expected, actual
  end

  def test_it_can_find_all_by_cc_number
    actual = @tr.find_all_by_credit_card_number(4297222478855497)
    expected = [@tr.all[4]]

    assert_equal expected, actual
  end

  def test_it_can_find_all_by_successful_result
    actual = @tr.find_all_by_result("success").count

    assert_equal 40, actual
  end

  def test_it_can_find_all_by_failed_result
    actual = @tr.find_all_by_result("failed").count

    assert_equal 10, actual
  end
end

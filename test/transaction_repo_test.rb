require_relative 'test_helper'
require_relative '../lib/transaction_repo'

class TransactionRepoTest < Minitest::Test
  attr_reader :tr

  def setup
    @tr = TransactionRepo.new("./data/transaction_fixtures.csv")
  end

  def test_it_exists
    assert_instance_of TransactionRepo, tr
  end

  def test_it_returns_all_transactions
    assert_equal 101, tr.all.count
  end

  def test_it_can_find_by_id
    assert_equal 46, tr.find_by_id(2).invoice_id
  end

  def test_returns_nil_for_bad_id
    assert_nil tr.find_by_id(00)
  end

  def test_it_can_find_all_by_invoice_id
    assert_equal 1, tr.find_all_by_invoice_id(46).count
  end

  def test_returns_empty_array_for_bad_invoice_id
    assert_equal [], tr.find_all_by_invoice_id(00)
  end

  def test_it_can_find_all_xactions_by_cc_num
    assert_equal 1, tr.find_all_by_credit_card_number("4271805778010747").count
  end

  def test_it_returns_empty_array_for_bad_cc_num
    assert_equal [], tr.find_all_by_credit_card_number("0000000")
  end

  def test_it_can_find_all_by_result
    assert_equal 78, tr.find_all_by_result("success").count
  end

  def test_it_can_find_failed_results
    assert_equal 23, tr.find_all_by_result("failed").count
  end

  def test_returns_empty_array_for_invalid_result
    assert_equal [], tr.find_all_by_result("shamalamadingdong")
  end
end

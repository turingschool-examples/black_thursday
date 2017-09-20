require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction_repo'

class TransactionRepoTest < MiniTest::Test
  attr_reader :tr

  def setup
    @tr = TransactionRepo.new("./data/transactions.csv")
  end

  def test_it_exists
    assert_instance_of TransactionRepo, tr
  end

  def test_all_returns_all_transactions
    assert_instance_of Array, tr.all
    assert_equal 4985, tr.all.count
  end

  def test_find_by_id_returns_matching_transaction_id
    assert_equal 702, tr.find_by_id(15).invoice_id
  end

  def test_find_all_by_invoice_id_returns_all_matches
    assert_equal 2, tr.find_all_by_invoice_id(46).count
  end

  def test_find_all_by_credit_card_number_returns_all_matches
    assert_equal 1, tr.find_all_by_credit_card_number(4318767847968505).count
  end

  def test_find_all_by_result_returns_all_matches
    expected_1 = tr.find_all_by_result("success").count
    expected_2 = tr.find_all_by_result("failed").count
    assert_equal 4158, expected_1
    assert_equal 827, expected_2
    assert_equal 4985, expected_1 + expected_2
  end
end

require_relative 'test_helper'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  attr_reader :parent, :repo
  def setup
    @parent = Minitest::Mock.new
    @repo = TransactionRepository.new('./test/assets/test_transactions.csv', parent)
  end

  def test_that_repo_stores_array_of_all_transactions
    assert_equal 1, repo.all[0].id
    assert_equal 67, repo.all.count
  end

  def test_that_repo_find_transaction_by_id
    assert_equal 30, repo.find_by_id(1).invoice_id
  end

  def test_that_find_by_id_returns_nil_if_no_matching_id
    assert_equal nil, repo.find_by_id(234523452345)
  end

  def test_that_repo_finds_transactions_by_invoice_id
    assert_equal 1, repo.find_all_by_invoice_id(55).count
  end

  def test_that_find_by_invoice_id_returns_empty_array_if_no_matches
    assert_equal [], repo.find_all_by_invoice_id(234523452345)
  end

  def test_that_repo_finds_transactions_with_matching_credit_card_number
    assert_equal 3, repo.find_all_by_credit_card_number(4463525332822998).count
  end

  def test_that_find_by_credit_card_number_returns_empty_array_if_no_matches
    assert_equal [], repo.find_all_by_credit_card_number(4463525332822979)
  end

  def test_that_repo_finds_transactions_with_given_status
    assert_equal 52, repo.find_all_by_result("success").count
  end

  def test_it_calls_parent_when_looking_for_invoice
    parent.expect(:find_invoice_by_invoice_id, nil, [6])
    repo.find_invoice_by_invoice_id(6)
    parent.verify
  end

end
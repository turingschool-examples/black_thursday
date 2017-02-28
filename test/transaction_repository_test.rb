require './test/test_helper'
require 'pry'

class TransactionRepositoryTest < Minitest::Test
  def setup
    @transaction_csv = './test/fixtures/transactions.csv'
    @parent = SalesEngine.new
    @repo = TransactionRepository.new(@transaction_csv, @parent)
  end

  def test_it_exists
    assert @repo
  end

  def test_all
    assert_equal 4985, @repo.all.length
  end

  def test_find_by_id
    assert_equal Transaction, @repo.find_by_id(4).class
    assert_nil @repo.find_by_id(0)
  end

  def test_finds_all_invoice_id
    assert_equal 2, @repo.find_all_by_invoice_id(2179).length
    assert_equal [], @repo.find_all_by_invoice_id(0)
  end

  def test_finds_all_cred_card
    assert_equal 1, @repo.find_all_by_credit_card_number(4048033451067370).length
    assert_equal [], @repo.find_all_by_credit_card_number(0)
  end

  def test_finds_all_result
    assert_equal 4158, @repo.find_all_by_result(:success).length
    assert_equal [], @repo.find_all_by_result(0)
  end

end
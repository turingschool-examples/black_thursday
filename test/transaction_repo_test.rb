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

  def test_it_can_find_all_by_invoice_id
    assert_equal 2, tr.find_all_by_invoice_id(2)
  end
end

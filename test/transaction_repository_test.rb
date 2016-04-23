require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < MiniTest::Test

  attr_reader :tr

  def setup
    test_helper = TestHelper.new
    @tr = TransactionRepository.new(test_helper.transactions)
  end

  def test_it_returns_an_array_of_all_transactions
    assert_equal Array, tr.all.class
    assert_equal 3, tr.all.count
  end


end

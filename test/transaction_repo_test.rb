require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require 'pry'
require 'CSV'
require './lib/transaction_repo'


class TransactionRepoTest < Minitest::Test

  def setup
    @engine = "engine"
    @tr = TransactionRepository.new(@engine)
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @tr
    assert_equal "engine", @tr.engine
  end

  def test_make_transactions
    assert_equal 1, @tr.transactions[1].id
    assert_equal "4297222478855497", @tr.transactions[5].credit_card_number
    assert_equal :failed, @tr.transactions[9].result
  end
end
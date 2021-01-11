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

  def test_all
    assert_equal 4985, @tr.all.length
  end

  def test_find_by_id
    assert_equal 2179, @tr.find_by_id(1).invoice_id
    assert_equal 3560, @tr.find_by_id(14).invoice_id
    assert_nil @tr.find_by_id(500000)
  end

  def test_find_all_by_invoice_id
    assert_equal 2, @tr.find_all_by_invoice_id(2179).length
    assert_equal 2, @tr.find_all_by_invoice_id(46).length
  end
end
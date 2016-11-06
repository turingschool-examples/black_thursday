require 'minitest/autorun'
require 'minitest/emoji'
require_relative '../lib/transaction_repo'
require 'csv'
require 'pry'

class TransactionRepoTest < Minitest::Test
  attr_reader :file,
              :sales_engine

  def setup
    @file = "./data/transactions.csv"
    @sales_engine = Minitest::Mock.new
  end

  def test_it_has_a_class
    tr = TransactionRepo.new(file, sales_engine)
    assert_equal TransactionRepo, tr.class
  end

  def test_it_can_display_all_transactions
    skip
    tr = TransactionRepo.new(file, sales_engine)
    assert tr.all
  end

  def test_it_can_find_by_id
    skip
    tr = TransactionRepo.new(file, sales_engine)
    assert_equal 7, tr.find_by_id(4920)
  end

  def test_it_can_find_by_invoice_id
    skip
    tr = TransactionRepo.new(file, sales_engine)
    assert_equal 4920, tr.find_by_invoice_id(4920)
  end

  def test_it_can_find_by_credit_card_number
    skip
    tr = TransactionRepo.new(file, sales_engine)
    assert_equal 1, tr.find_by_credit_card_number("4242424242424242")
  end
  
   def test_it_can_find_by_result
     skip
    tr = TransactionRepo.new(file, sales_engine)
    assert_equal 7, tr.find_all_by_result("pending")
  end
end
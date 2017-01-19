require 'minitest/autorun'
require 'minitest/emoji'
require_relative '../lib/transaction_repo'
require_relative "../test/test_helper"
require 'csv'
require 'pry'

class TransactionRepoTest < Minitest::Test
  attr_reader :file,
              :sales_engine

  def setup
    @file = "./data/small_transaction_file.csv"
    @sales_engine = Minitest::Mock.new
  end

  def test_it_has_a_class
    tr = TransactionRepo.new(file, sales_engine)
    assert_equal TransactionRepo, tr.class
  end

  def test_it_can_display_all_transactions
    tr = TransactionRepo.new(file, sales_engine)
    assert tr.all
  end

  def test_it_can_find_by_id
    tr = TransactionRepo.new(file, sales_engine)
    assert_equal 412, tr.find_by_id(412).id
  end

  def test_it_can_find_by_invoice_id
    tr = TransactionRepo.new(file, sales_engine)
    assert_equal 99, tr.find_by_invoice_id(511).id
  end

  def test_it_can_find_by_credit_card_number
    tr = TransactionRepo.new(file, sales_engine)
    assert_equal 1, tr.find_all_by_credit_card_number("4191976989764980").length
  end
  
   def test_it_can_find_by_result
    tr = TransactionRepo.new(file, sales_engine)
    assert_equal 117, tr.find_all_by_result("failed").length
  end
end
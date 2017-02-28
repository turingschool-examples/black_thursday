require 'minitest/autorun'
require 'minitest/pride'
require './lib/transaction_repository.rb'
require './lib/sales_engine'
require 'simplecov'
require './lib/csv_parser.rb'
SimpleCov.start

class TransactionRepositoryTest < Minitest::Test
  include CsvParser

  def test_it_exists
    data = open_file("./test/fixtures/transaction_three.csv")
    tr = TransactionRepository.new(data)

   assert_instance_of TransactionRepository, tr
  end

  def test_all_returns_array_of_transactions
    data = open_file("./test/fixtures/transaction_three.csv")
    tr = TransactionRepository.new(data)

    assert_equal 3, tr.all.length
    assert_instance_of Array, tr.all
  end

def test_find_by_id
    data = open_file("./test/fixtures/transaction_three.csv")
    tr = TransactionRepository.new(data)

    assert_instance_of Transaction, tr.find_by_id(1)
    assert_equal 2179, tr.find_by_id(1).invoice_id
    assert_nil tr.find_by_id(4)
  end


  def test_find_all_by_invoice_id
    data = open_file("./test/fixtures/transaction_100.csv")
    tr = TransactionRepository.new(data)

    assert_equal 2, tr.find_all_by_invoice_id(3477).length
    assert_equal [], tr.find_all_by_invoice_id(3672)
    assert_instance_of Transaction, tr.find_all_by_invoice_id(3477).first
  end

  def test_find_all_by_credit_card_number
    data = open_file("./test/fixtures/transaction_100.csv")
    tr = TransactionRepository.new(data)

    assert_equal 4068631943231473, tr.find_all_by_credit_card_number(4068631943231473).first.credit_card_number
    assert_instance_of Transaction, tr.find_all_by_credit_card_number(4068631943231473).first
    assert_equal [], tr.find_all_by_credit_card_number(4068631943231400)
  end

  def test_find_all_by_result
    data = open_file("./test/fixtures/transaction_100.csv")
    tr = TransactionRepository.new(data)

    assert_equal 23, tr.find_all_by_result("failed").length
    assert_instance_of Transaction, tr.find_all_by_result("failed").first
    assert_equal [], tr.find_all_by_result("banana")
  end

  
end


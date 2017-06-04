require 'csv'
require_relative 'test_helper'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < MiniTest::Test

  def setup
    @files = './test/data/transactions_test.csv'
  end

  def test_if_create_class
    tr = TransactionRepository.new(@files)

    assert_instance_of TransactionRepository, tr
  end

  def test_initialize_and_population_of_items
    tr = TransactionRepository.new(@files)

    assert_equal 10, tr.all.length
  end

  def test_if_find_by_id_returns_correct_value_for_method
    tr = TransactionRepository.new(@files)

    assert_equal tr.all[0], tr.find_by_id(1)
    assert_nil tr.find_by_id(122)
  end

  def test_if_find_all_by_invoice_id_works
    tr = TransactionRepository.new(@files)

    actual_1 = tr.find_all_by_invoice_id(2179)
    actual_2 = tr.find_all_by_invoice_id(12)

    assert_equal [tr.all[0]], actual_1
    assert_equal [], actual_2

  end

end

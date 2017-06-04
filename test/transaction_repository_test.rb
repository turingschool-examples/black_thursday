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

end

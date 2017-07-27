require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/transaction_repo'

class TransactionRepositoryTest < Minitest::Test

  def test_it_exist
    transaction_repo = TransactionRepository.new("csv_data")

    assert_instance_of TransactionRepository, transaction_repo
  end

  def test_can_find_by_id
    transaction_repo = TransactionRepository.new("csv_data")
    id = 1

    assert_nil 0, transaction_repo.find_by_id(id)
    assert_instance_of Transaction, transaction_repo.find_by_id(id)
    assert_equal id, transaction_repo.find_by_id(id)
  end

  def test_can_find_all_by_invoice_id
    transaction_repo = TransactionRepository.new("csv_data")
    invoice_id = 46

    assert_nil 0, transaction_repo.find_all_by_invoice_id(invoice_id)
    
  end

  def test_can_find_all_by_CC_number
    transaction_repo = TransactionRepository.new("csv_data")

  end

  def test_can_find_all_by_result
    transaction_repo = TransactionRepository.new("csv_data")

  end

end

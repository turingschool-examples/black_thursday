require_relative 'test_helper'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  def test_it_exists
    tr = TransactionRepository.new("./data/transactions.csv")

    assert_instance_of TransactionRepository, tr
  end

  def test_it_returns_array_of_all_invoices
    tr = TransactionRepository.new("./data/transactions.csv")

    assert_equal 4985, tr.all.count
  end

  def test_it_can_find_by_id
    tr = TransactionRepository.new("./data/transactions.csv")


    assert_instance_of Transaction, tr.find_by_id(1)
    assert_equal 5, tr.find_by_id(5).id
  end

  def test_it_can_find_all_by_invoice_id
    tr = TransactionRepository.new("./data/transactions.csv")

    instances = tr.find_all_by_invoice_id(12)

    assert_equal 12, instances[0].invoice_id
    assert_equal 1, instances.count
  end

  def test_it_can_find_all_by_cc_number
    tr = TransactionRepository.new("./data/transactions.csv")

    instances = tr.find_all_by_credit_card_number(4297222478855497)

    assert_equal 1, instances.count
  end

  def test_it_can_find_all_by_result
    tr = TransactionRepository.new("./data/transactions.csv")

    instances = tr.find_all_by_result("success")

    assert_equal "success", instances[4].result
    assert_equal 4158, instances.count
  end
end

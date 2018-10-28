require 'minitest/autorun'
require 'minitest/pride'
require './lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  def test_it_exists
    tr = TransactionRepository.new("./data/transactions.csv")

    assert_instance_of TransactionRepository, tr
  end

  def test_it_has_invoices
    tr = TransactionRepository.new("./data/transactions.csv")

    assert_instance_of Transaction, tr.all[0]
    assert_equal 4985,tr.all.count
  end

  def test_it_can_find_by_id
    tr = TransactionRepository.new("./data/transactions.csv")

    assert_equal tr.all[1], tr.find_by_id(2)
  end

  def test_it_can_find_all_by_id
    tr = TransactionRepository.new("./data/transactions.csv")

    assert_equal [tr.all[0], tr.all[766]], tr.find_all_by_invoice_id(2179)
    assert_equal [], tr.find_all_by_invoice_id("aaa")
  end
end

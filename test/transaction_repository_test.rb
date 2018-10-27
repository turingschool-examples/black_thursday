require_relative './test_helper'


class TransactionRepositoryTest < Minitest::Test

  def test_it_exists
    tr = TransactionRepository.new('./test/data/invoice_test_data.csv')
    assert_instance_of TransactionRepository, tr
  end

  def test_invoice_item_repo_has_repository_array_and_returns_all
    tr = TransactionRepository.new('./test/data/invoice_item_sample.csv')
    assert_equal 10, tr.all.count
    assert_instance_of Array, tr.all
  end

  def test_it_can_find_by_transaction_by_id
    tr = TransactionRepository.new('./test/data/invoice_item_sample.csv')
    result = tr.repo_array[1]
    assert_equal result, tr.find_by_id(2)
    assert_instance_of Transaction, tr.find_by_id(2)
  end

  def test_find_all_by_invoice_id
    tr = TransactionRepository.new('./test/data/invoice_item_sample.csv')
    assert_equal 2, tr.find_all_by_invoice_id(2).count
  end

end

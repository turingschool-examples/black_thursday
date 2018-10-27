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

end

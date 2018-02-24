require_relative 'test_helper'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  def setup
    @transaction_repo = TransactionRepository.new('./test/fixtures/transactions.csv')
  end

  def test_class_can_be_instantiated
    assert_instance_of TransactionRepository, @transaction_repo
  end

  def test_can_return_all_transactions
    assert_equal 6, @transaction_repo.all.count
  end

  def test_can_find_by_id
    assert_nil @transaction_repo.find_by_id(800000)
    assert_equal 2179, @transaction_repo.find_by_id(1).invoice_id
  end

  def test_can_find_all_by_invoice_id
    assert_equal [], @transaction_repo.find_all_by_invoice_id(800000)
    assert_equal 2, @transaction_repo.find_all_by_invoice_id(2179).count
  end

  def test_can_find_all_by_credit_card_number
    assert_equal [], @transaction_repo.find_all_by_credit_card_number(493828384882123423)
    assert_equal 2179, @transaction_repo.find_all_by_credit_card_number(4068631943231473).first.invoice_id
  end

  def test_can_find_all_by_result
    assert_equal [], @transaction_repo.find_all_by_result("just didn't care")
    assert_equal 5, @transaction_repo.find_all_by_result("success").count
  end
end

require 'time'
require_relative 'test_helper'
require_relative '../lib/fileio'
require_relative '../lib/transaction'
require_relative '../lib/transaction_repository'

# Test for the TransactionRepository class
class TransactionRepositoryTest < Minitest::Test
  def setup
    file_path = FileIO.load('./test/fixtures/test_transactions.csv')
    @t_repo = TransactionRepository.new(file_path)
    @new_transaction = @t_repo.create(
      invoice_id: 621,
      credit_card_number: '4271805778010747',
      credit_card_expiration_date: '0209',
      result: :success,
      created_at: '2009-12-09 12:08:04 UTC',
      updated_at: '2010-12-09 12:08:04 UTC'
    )
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @t_repo
  end

  def test_creating_an_index_of_transactions_from_data
    assert_instance_of Hash, @t_repo.transactions
    assert_instance_of Transaction, @t_repo.transactions[1]
    assert_instance_of Transaction, @t_repo.transactions[2]
    assert_instance_of Transaction, @t_repo.transactions[3]
  end

  def test_all_returns_an_array_of_all_transaction_instances
    assert_instance_of Array, @t_repo.all
  end

  def test_all_returns_correct_ids
    all_transactions = @t_repo.all
    actual_all_ids = all_transactions.map(&:id)
    expected = [1, 2, 3, 4, 5]
    assert_equal expected, actual_all_ids
  end

  def test_can_find_by_id
    actual_one = @t_repo.find_by_id(1)
    actual_two = @t_repo.find_by_id(2)
    assert_instance_of Transaction, actual_one
    assert_instance_of Transaction, actual_two
    assert_equal 2179, actual_one.invoice_id
    assert_equal 46, actual_two.invoice_id
  end

  def test_can_find_all_by_invoice_id
    actual = @t_repo.find_all_by_invoice_id(750)
    result = actual.all? do |transaction|
      transaction.class == Transaction
    end
    assert result
    ids = actual.map(&:id)
    assert_equal [3, 4], ids
  end

  def test_can_find_all_by_credit_card_number
    actual = @t_repo.find_all_by_credit_card_number('4271805778010747')
    result = actual.all? do |transaction|
      transaction.class == Transaction
    end
    assert result
    ids = actual.map(&:id)
    assert_equal [3, 4, 5], ids
  end

  def test_can_find_all_by_result
    actual_success = @t_repo.find_all_by_result(:success)
    actual_failed = @t_repo.find_all_by_result(:failed)
    assert_instance_of Transaction, actual_success[0]
    assert_instance_of Transaction, actual_failed[0]
    success_ids = actual_success.map(&:id)
    assert_equal [1, 2, 3, 5], success_ids
    failed_ids = actual_failed.map(&:id)
    assert_equal [4], failed_ids
  end

  def test_it_can_generate_next_transaction_id
    expected = 6
    actual = @t_repo.create_new_id
    assert_equal expected, actual
  end

  def test_can_create_new_transaction
    assert_instance_of Transaction, @new_transaction
    assert_equal 5, @t_repo.transactions.count
    assert_equal @new_transaction, @t_repo.transactions[5]
  end

  def test_transaction_can_be_updated
    @t_repo.update(5, credit_card_number: 4271805778010748)
    assert_equal 4271805778010748, @t_repo.transactions[5].credit_card_number
    @t_repo.update(5, credit_card_expiration_date: '0210')
    assert_equal '0210', @t_repo.transactions[5].credit_card_expiration_date
    @t_repo.update(5, result: 'failed')
    assert_equal :failed, @t_repo.transactions[5].result
  end

  def test_transaction_can_be_deleted
    @t_repo.delete(5)
    assert_equal 4, @t_repo.transactions.count
    assert_nil @t_repo.transactions[5]
  end
end

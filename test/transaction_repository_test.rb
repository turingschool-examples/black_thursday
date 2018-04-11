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
      credit_card_number: 4271805778010747,
      credit_card_expiration_date: '0209',
      result: 'success',
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
    skip
    all_transactions = @t_repo.all
    actual_all_ids = all_transactions.map(&:id)
    expected = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 25, 37, 38]
    assert_equal expected, actual_all_ids
  end

  def test_all_returns_correct_customer_ids
    skip
    all_transactions = @t_repo.all
    actual_all_cust_ids = all_transactions.map(&:customer_id)
    expected = [1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 6, 9, 7]
    assert_equal expected, actual_all_cust_ids
  end

  def test_can_find_by_id
    skip
    actual_one = @t_repo.find_by_id(1)
    actual_two = @t_repo.find_by_id(2)
    assert_instance_of Transaction, actual_one
    assert_instance_of Transaction, actual_two
    assert_equal '2009-02-07', actual_one.created_at
    assert_equal '2012-11-23', actual_two.created_at
  end

  def test_can_find_all_by_customer_id
    skip
    actual = @t_repo.find_all_by_customer_id(2)
    result = actual.all? do |transaction|
      transaction.class == Transaction
    end
    assert result
    ids = actual.map(&:id)
    assert_equal [9, 10], ids
  end

  def test_can_find_all_by_merchant_id
    skip
    actual = @t_repo.find_all_by_merchant_id(12335938)
    result = actual.all? do |transaction|
      transaction.class == Transaction
    end
    assert result
    ids = actual.map(&:id)
    assert_equal [1], ids
  end

  def test_can_find_all_by_status
    skip
    actual_pending = @t_repo.find_all_by_status(:pending)
    actual_shipped = @t_repo.find_all_by_status(:shipped)
    actual_returned = @t_repo.find_all_by_status(:returned)
    assert_instance_of Transaction, actual_pending[0]
    assert_instance_of Transaction, actual_shipped[0]
    assert_instance_of Transaction, actual_returned[0]
    pending_ids = actual_pending.map(&:id)
    assert_equal [1, 4, 5, 6, 7, 10, 38], pending_ids
    shipped_ids = actual_shipped.map(&:id)
    assert_equal [2, 3, 8, 9], shipped_ids
    returned_ids = actual_returned.map(&:id)
    assert_equal [25, 37], returned_ids
  end

  def test_it_can_generate_next_transaction_id
    skip
    expected = 39
    actual = @t_repo.create_new_id
    assert_equal expected, actual
  end

  def test_can_create_new_transaction
    skip
    assert_instance_of Transaction, @new_transaction
    assert_equal 13, @t_repo.transactions.count
    assert_equal 7, @t_repo.transactions[38].customer_id
    assert_equal 12334105, @t_repo.transactions[38].merchant_id
    assert_equal :pending, @t_repo.transactions[38].status
    assert_equal '2009-12-09 12:08:04 UTC', @t_repo.transactions[38].created_at
    assert_equal '2010-12-09 12:08:04 UTC', @t_repo.transactions[38].updated_at
  end

  def test_transaction_can_be_updated
    skip
    @t_repo.update(38, status: :shipped)
    assert_equal :shipped, @t_repo.transactions[38].status
  end

  def test_transaction_can_be_deleted
    skip
    @t_repo.delete(38)
    assert_equal 12, @t_repo.transactions.count
    assert_nil @t_repo.transactions[38]
  end
end

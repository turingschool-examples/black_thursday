require_relative 'test_helper.rb'
require_relative '../lib/transaction_repository.rb'
require_relative '../lib/sales_engine.rb'
require_relative './master_hash.rb'
require 'pry'

class TransactionRepositoryTest < Minitest::Test
  def setup
    test_engine = TestEngine.new.god_hash
    sales_engine = SalesEngine.new(test_engine)
    @transaction_repository = sales_engine.transactions
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @transaction_repository
  end

  def test_transaction_repository_can_hold_items
    assert_equal 30, @transaction_repository.all.count
    assert (@transaction_repository.all.all? { |transaction| transaction.is_a?(Transaction)})
  end

  def test_it_can_find_transaction_by_id
    result = @transaction_repository.find_by_id(8)

    result_nil = @transaction_repository.find_by_id(1_989)

    assert_instance_of Transaction, result
    assert_equal 8, result.id
    assert_nil result_nil
  end

  def test_it_can_find_all_transactions_by_invoice_id
    result = @transaction_repository.find_all_by_invoice_id(1752)

    result2= @transaction_repository.find_all_by_invoice_id(25)

    assert_equal 1, result.length
    assert_equal 1752, result[0].invoice_id
    assert_instance_of Transaction, result[0]
    assert_equal [], result2
  end

  def test_it_can_find_all_by_credit_card_number
    result = @transaction_repository.find_all_by_credit_card_number(4055813232766404)

    result_nil = @transaction_repository.find_all_by_credit_card_number(1_989)

    assert_equal 1, result.length
    assert_instance_of Transaction, result[0]
    assert_equal [], result_nil
  end

  def test_it_can_find_all_by_result
    result = @transaction_repository.find_all_by_result('success')

    result2 = @transaction_repository.find_all_by_result('failed')

    result3 = @transaction_repository.find_all_by_result('nope')

    assert_equal 24, result.length
    assert_equal 6, result2.length
    assert_equal 0, result3.length
    assert_instance_of Transaction, result[0]
    assert_instance_of Array, result
    assert_equal [], result3
  end

  def test_transaction_repo_to_engine_can_return_invoice
    result = @transaction_repository.transaction_repo_finds_invoice_via_engine(18)

    assert_equal 18, result.id
    assert_equal 5, result.customer_id
    assert_equal 12334123, result.merchant_id
    assert_equal :shipped, result.status
  end

  def test_inspect
    assert_equal "#<TransactionRepository 30 rows>", @transaction_repository.inspect
  end
end

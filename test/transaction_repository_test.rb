require_relative 'test_helper'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  def setup
    @transaction_repo = TransactionRepository.new('./test/fixtures/transactions_sample.csv')
  end

  def test_if_it_exists
    assert_instance_of TransactionRepository, @transaction_repo
  end

  def test_inspect_method
    assert_instance_of String, @transaction_repo.inspect
  end

  def test_if_invoice_transaction_repository_has_transactions
    assert_instance_of Array, @transaction_repo.all
    assert_equal 10, @transaction_repo.all.count
    assert @transaction_repo.all.all? { |transaction| transaction.is_a?(Transaction)}
  end

  def test_if_it_can_load_correct_ids
    assert_equal 1, @transaction_repo.all.first.id
    assert_equal 9, @transaction_repo.all[8].id
  end

  def test_it_can_find_a_transaction_by_id
    result = @transaction_repo.find_by_id(8)

    assert_instance_of Transaction, result
    assert_equal 8, result.id
    assert_equal 4898, result.invoice_id
    assert_equal 4839506591130477, result.credit_card_number
  end

  def test_it_can_find_another_transaction_by_id
    result = @transaction_repo.find_by_id(4842)

    assert_instance_of Transaction, result
    assert_equal 4842, result.id
    assert_equal 819, result.invoice_id
    assert_equal 4735941324612447, result.credit_card_number
    assert_equal "0620", result.credit_card_expiration_date
  end

  def test_it_can_return_nil_when_there_is_no_match_for_transaction_id
    result = @transaction_repo.find_by_id(32334388)

    assert_nil result
  end

  def test_it_can_find_all_transactions_by_invoice_id
    result = @transaction_repo.find_all_by_invoice_id(2179)

    assert result.class == Array
    assert_equal 2, result.length
    assert_instance_of Transaction, result.first
    assert_equal 1, result.first.id
    assert_equal 2179, result.first.invoice_id
    assert_equal 4068631943231473, result.first.credit_card_number
    assert_equal "0217", result.last.credit_card_expiration_date
  end

  def test_it_returns_empty_array_when_there_is_no_match_for_invoice_id
    result = @transaction_repo.find_all_by_invoice_id(6666666)

    assert_equal [], result
  end

  def test_it_can_find_all_transactions_by_credit_card_number
    result = @transaction_repo.find_all_by_credit_card_number(4068631943231473)

    assert result.class == Array
    assert_equal 2, result.length
    assert_instance_of Transaction, result.first
    assert_equal 9, result.last.id
    assert_equal 2179, result.first.invoice_id
    assert_equal 4068631943231473, result.first.credit_card_number
    assert_equal "0217", result.last.credit_card_expiration_date
  end

  def test_it_returns_empty_array_when_there_is_no_match_for_credit_card_number
    result = @transaction_repo.find_all_by_credit_card_number(6666666)

    assert_equal [], result
  end

  def test_it_can_find_all_transactions_by_result
    result = @transaction_repo.find_all_by_result("success")

    assert result.class == Array
    assert_equal 8, result.length
    assert_instance_of Transaction, result.first
    assert_equal 4842, result.last.id
    assert_equal 2179, result.first.invoice_id
    assert_equal 4068631943231473, result.first.credit_card_number
    assert_equal "0620", result.last.credit_card_expiration_date
  end

  def test_it_returns_empty_array_when_there_is_no_match_for_credit_card_number
    result = @transaction_repo.find_all_by_result(6666666)

    assert_equal [], result
  end

end
